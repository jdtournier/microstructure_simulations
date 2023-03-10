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




% gradients: 
% sweep from x-axis to z-axis in equidistant increments
angle = (0:0.1:1)'.*pi/2;
grad_dirs = [cos(angle) 0.*angle sin(angle)];
grad_amps = 0:4:40; 
disp ([ 'b-values: ' sprintf('%.3f ', grad2bvalues (grad_amps, param.delta, param.Delta)) 'ms/µm²' ])

plot_signal (param, grad_dirs, grad_amps);
plot_signal_polar (param, grad_amps);

