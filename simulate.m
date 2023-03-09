clear param;

% axon radius and spacing (in µm):
param.axon_radius = 0.15;
param.axon_separation = 0.2;

% diffusivity of free water at 37°C (in µm²/ms - i.e. 10e-9 mm²/s):
param.D = 3e-3; 

% gradient pulse duration and separation (in ms):
param.delta = 20;
param.Delta = 50;

% display walkers live during simulation (slower):
show_walkers_plot = false;

% number of molecules to simulate:
param.num_walkers = 10000;


% compute safe step size:
param.step_size = 0.9 * (1 - 2*param.axon_radius/param.axon_separation);
% work out time step this correspond to based on diffusivity:
param.timestep = (param.axon_separation*param.step_size)^2/(6*param.D);

disp (sprintf ('step size: %.3f µm', param.step_size))
disp (sprintf ('time step: %.3f ms', param.timestep))

delta_steps = round(param.delta/param.timestep);
Delta_steps = round(param.Delta/param.timestep);

param.gradient_waveform = zeros(1,delta_steps+Delta_steps);
param.gradient_waveform(1:delta_steps) = 1;
param.gradient_waveform(Delta_steps+(1:delta_steps)) = -1;

disp (sprintf ('number of time steps: %.3d', numel(param.gradient_waveform)))



param = run_simulation (param, show_walkers_plot);




% gradients: 
% sweep from x-axis to z-axis in equidistant increments
angle = (0:0.1:1)'.*pi/2;
grad_dirs = [cos(angle) 0.*angle sin(angle)];
grad_amps = 0:2:40; 
disp ([ 'b-values: ' sprintf('%.3f ', grad2bvalues (grad_amps, param.delta, param.Delta)) 's/mm²' ])

plot_signal (param, grad_dirs, grad_amps, true)
%plot_signal_polar (param, grad_amps)

