function signal = plot_signal (param, gradient_directions, gradient_amplitudes, figure_handle)

arguments
    param struct
    gradient_directions (:,3) double
    gradient_amplitudes (1,:) double
    figure_handle (1,1) double = 2
end

signal = compute_signals (param, gradient_directions, gradient_amplitudes);
bvalues = grad2bvalues (gradient_amplitudes, param.delta, param.Delta);

figure(figure_handle);
t = tiledlayout('flow','TileSpacing','compact');

nexttile
plot (bvalues, signal);
title ('signal vs. b-value')
xlabel ('b-value')
xlim(bvalues([1 end]))
ylim([0 1]);

for n=1:size(gradient_directions,1), l{n} = [ 'G = [ ' num2str(gradient_directions(n,:), '%4.2f ') ']' ]; end
legend(l, 'location', 'northeast');

nexttile
plot (signal')
title ('signal vs. gradient direction');
xlabel ('gradient direction')
xlim([1 size(gradient_directions,1)])
ylim ([0 1])

clear l;
for n=1:numel(bvalues), l{n} = [ 'b = ' num2str(bvalues(n)) ]; end
legend (l, 'location', 'northeast');

