function param = run_simulation (param, live_plot, figure_handle)

arguments
    param struct
    live_plot (1,1) double = false
    figure_handle (1,1) double = 1
end

radius = param.axon_radius / param.axon_separation;
step_size = param.step_size / param.axon_separation;

X = 20*(rand(3, param.num_walkers)-0.5);
param.assignments = in_fibre (X, radius);
%X = reflect (X, radius, param.assignments);
param.cumulative_positions = zeros(3, param.num_walkers);

if live_plot, plot_walkers (X.*param.axon_separation, param.assignments, figure_handle); end

progress = 0;
prev_progress = -1;
fprintf (1, '       ');

for k=1:numel(param.gradient_waveform)

    % each walker takes a random step:
    X = random_step (X, step_size);
    % make sure walkers remain within their original compartment:
    X = reflect (X, radius, param.assignments);
    % update phase based on current gradient:
    param.cumulative_positions = param.cumulative_positions + param.gradient_waveform(k)*X;

    % optionally plot walkers live during simulation:
    if live_plot, plot_walkers (X.*param.axon_separation, param.assignments, figure_handle); end

    progress = floor(100*k/numel(param.gradient_waveform));
    if progress ~= prev_progress
      fprintf (1, '\b\b\b\b\b\b\b%3d%%...', progress);
      prev_progress = progress;
    end

end

fprintf (1, '\n');
param.cumulative_positions = param.cumulative_positions * param.axon_separation;

