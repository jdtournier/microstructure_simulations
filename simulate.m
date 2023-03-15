clear param;

% display walkers live during simulation (slower):
show_walkers_plot = false;

% axon radius and spacing (in µm):
param.axon_radius = 0.5;
param.axon_separation = 1.2;

% diffusivity of free water at 37°C (in µm²/ms - i.e. 10e-3 mm²/s):
param.D = 3; 

% number of molecules to simulate:
param.num_walkers = 2000;

% use a suitable step size:
param.step_size = 0.1;

param = generate_PGSE_waveform (param, 20, 50);

disp (sprintf ('step size: %.3f µm', param.step_size))
disp (sprintf ('time step: %.3f ms', param.timestep))
disp (sprintf ('number of time steps: %.3d', numel(param.gradient_waveform)))



% it's a good idea to save your results to file, so you can avoid having to
% recompute them later. This bit of code allows you to do just that:
try
  load results
catch ME
  % only perform simulations if we fail to load the results file
  % delete the results.mat file to force re-execution
  param = run_simulation (param, show_walkers_plot);
  save results param
end

% now we can pick a set of gradient directions and amplitudes to compute the
% dMRI signal:

% gradients sweeps from x-axis to z-axis in equidistant increments:
angle = (0:0.1:1)'.*pi/2;
grad_dirs = [cos(angle) 0.*angle sin(angle)];

% gradient amplitudes from zero to 40 mT/m:
grad_amps = 0:4:40; 

% show what b-values these gradients give rise to, based on gradient waveform
% used during simulations:
b = grad2bvalues (grad_amps, param.delta, param.Delta);
disp ([ 'b-values: ' sprintf('%.3f ', b) 'ms/µm²' ])

% compute the expected dMRI signals from simulation results:
sig = compute_signals (param, grad_dirs, grad_amps);



% different ways of plotting the signal:
tiledlayout('flow','TileSpacing','compact');

nexttile
plot (angle, sig);
xlabel 'angle';
ylim ([0 1]);
title 'signal as a function of angle'
labels = {};
for n=1:numel(b), labels{n} = sprintf('b = %.3f ms/µm²', b(n)); end
legend (labels, 'Location', 'eastoutside')

nexttile
plot (b, sig')
xlabel 'b-value';
ylim ([0 1]);
title 'signal as a function of angle'
labels = {};
for n=1:numel(angle), labels{n} = sprintf('θ = %.3f°', angle(n)); end
legend (labels, 'Location', 'eastoutside')

nexttile
% for polar plot, need the full 360° (2π) range:
angle = (0:0.02:2)'.*pi;
grad_dirs = [cos(angle) 0.*angle sin(angle)];
sig = compute_signals (param, grad_dirs, grad_amps);

polarplot (angle, sig);
title 'signal as a function of angle'
labels = {};
for n=1:numel(b), labels{n} = sprintf('b = %.3f ms/µm²', b(n)); end
legend (labels, 'Location', 'eastoutside')

