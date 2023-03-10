clear param;

% display walkers live during simulation (slower):
show_walkers_plot = false;

% axon radius and spacing (in µm):
param.axon_radius = 0.9;
param.axon_separation = 2;

% diffusivity of free water at 37°C (in µm²/ms - i.e. 10e-3 mm²/s):
param.D = 3; 

% number of molecules to simulate:
param.num_walkers = 2000;

% compute safe step size:
param.step_size = min ([param.axon_radius (1-2*param.axon_radius/param.axon_separation)]);

param = generate_PGSE_waveform (param, 20, 50);

disp (sprintf ('step size: %.3f µm', param.step_size))
disp (sprintf ('time step: %.3f ms', param.timestep))
disp (sprintf ('number of time steps: %.3d', numel(param.gradient_waveform)))



param = run_simulation (param, show_walkers_plot);


% now we can pick a set of gradient directions and amplitudes to compute the
% dMRI signal:

% gradients sweeps from x-axis to z-axis in equidistant increments:
angle = (0:0.1:1)'.*pi/2;
grad_dirs = [cos(angle) 0.*angle sin(angle)];

% gradient amplitudes from zero to 40 mT/m:
grad_amps = 0:4:40; 

% show what b-values these gradients give rise to, based on gradient waveform
% used during simulations:
disp ([ 'b-values: ' sprintf('%.3f ', grad2bvalues (grad_amps, param.delta, param.Delta)) 'ms/µm²' ])

% two different ways of plotting the signal:
plot_signal (param, grad_dirs, grad_amps);
plot_signal_polar (param, grad_amps);

