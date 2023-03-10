function param = generate_PGSE_waveform (param, delta, Delta)

arguments
  param struct
  delta (1,1) double
  Delta (1,1) double
end

% work out time step based on step size and diffusivity:
param.timestep = (param.axon_separation*param.step_size)^2/(6*param.D);

delta_steps = round(delta/param.timestep);
Delta_steps = round(Delta/param.timestep);

param.delta = delta;
param.Delta = Delta;
param.gradient_waveform = zeros(1,delta_steps+Delta_steps);
param.gradient_waveform(1:delta_steps) = 1;
param.gradient_waveform(Delta_steps+(1:delta_steps)) = -1;

