function signal = compute_signals (param, gradient_directions, gradient_amplitudes)

  gradient_directions = gradient_directions./sqrt(sum(gradient_directions.^2,2));

  Gdotx = 1e-6 * gradient_directions * param.cumulative_positions;
  dphase = 2.68e8 * 1e-6 * param.timestep * gradient_amplitudes;

  signal = abs(sum(exp(1i*dphase'.*reshape(Gdotx, [ 1 size(Gdotx)])),3))./size(Gdotx,2);
