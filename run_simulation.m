function param = run_simulation (param, live_plot, figure_handle)

arguments
    param struct
    live_plot (1,1) double = false
    figure_handle (1,1) double = 1
end

% check for potential issues if step size could cause jump from one axon to
% another:
if 0.5-param.axon_radius < param.step_size/2
  throw (MException ('RandomWalkSimulation:stepsize', ...
    'step size may exceed inter-axon spacing - aborting'))
end

X = 20*(rand(3, param.num_walkers)-0.5);
param.assignments = in_fibre (X, param.axon_radius);
X = reflect (X, param.axon_radius, param.assignments);
param.cumulative_positions = zeros(3, param.num_walkers);

if live_plot, plot_walkers (X, param.assignments, 10, figure_handle); end

for k=1:numel(param.gradient_waveform)

    % each walker takes a random step:
    X = random_step (X, param.step_size);
    % make sure walkers remain within their original compartment:
    X = reflect (X, param.axon_radius, param.assignments);
    % update phase based on current gradient:
    param.cumulative_positions = param.cumulative_positions + param.gradient_waveform(k)*X;

    % optionally plot walkers live during simulation:
    if live_plot, plot_walkers (X, param.assignments, 10, figure_handle); end

end

param.cumulative_positions = param.cumulative_positions * param.axon_separation;

