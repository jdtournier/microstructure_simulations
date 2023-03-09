function plot_signal_polar (param, gradient_amplitudes, ndirs, figure_handle)

arguments
    param struct
    gradient_amplitudes (1,:) double
    ndirs (1,1) double = 200
    figure_handle (1,1) double = 3
end

bvalues = grad2bvalues (gradient_amplitudes, param.delta, param.Delta);
for n=1:numel(bvalues), l{n} = [ 'b = ' num2str(bvalues(n)) ]; end

angle = (0:(1/ndirs):1)'.*(2*pi);
gradient_directions = [cos(angle) 0.*angle sin(angle)];
signal = compute_signals (param, gradient_directions, gradient_amplitudes);

figure(figure_handle);

polarplot (angle, signal);
legend (l, 'location', 'eastoutside');
