function plot_signal (param, gradient_directions, gradient_amplitudes, with_assignments, figure_handle)

arguments
    param struct
    gradient_directions (:,3) double
    gradient_amplitudes (1,:) double
    with_assignments (1,1) double = false
    figure_handle (1,1) double = 2
end

if with_assignments, ncols=2; else ncols=1; end

gradient_directions = gradient_directions./sqrt(sum(gradient_directions.^2,2))

Gdotx = 1e-6 * gradient_directions * param.cumulative_positions;
dphase = 1e4 * param.timestep * gradient_amplitudes

bvalues = grad2bvalues (gradient_amplitudes, param.delta, param.Delta);


figure(figure_handle);
t = tiledlayout('flow','TileSpacing','compact');

nexttile
plot (bvalues, abs(sum(exp(1i*dphase'.*reshape(Gdotx, [ 1 size(Gdotx)])),3))./size(Gdotx,2))
title ('signal vs. b-value')
xlabel ('b-value')
xlim(bvalues([1 end]))
ylim([0 1]);

for n=1:size(gradient_directions,1), l{n} = [ 'G = [ ' num2str(gradient_directions(n,:), '%4.2f ') ']' ]; end
legend(l, 'location', 'northeast');

nexttile
plot (abs(sum(exp(1i*dphase'.*reshape(Gdotx, [ 1 size(Gdotx)])),3))'./size(Gdotx,2))
title ('signal vs. gradient direction');
xlabel ('gradient direction')
xlim([1 size(gradient_directions,1)])
ylim([0 1]);
clear l;
for n=1:numel(bvalues), l{n} = [ 'b = ' num2str(bvalues(n)) ]; end
legend (l, 'location', 'northeast');


if ncols>1
    nexttile
    P0 = Gdotx(:,isnan(param.assignments(1,:)));
    plot (bvalues, abs(sum(exp(1i*dphase'.*reshape(P0, [ 1 size(P0)])),3))./size(Gdotx,2))
    xlim(bvalues([1 end]))
    ylim([0 1]);
    title ('signal vs. b-value (extra-axonal)')
    xlabel ('b-value')


    nexttile
    P1 = Gdotx(:,~isnan(param.assignments(1,:)));
    plot (bvalues, abs(sum(exp(1i*dphase'.*reshape(P1, [ 1 size(P1)])),3))./size(Gdotx,2))
    xlim(bvalues([1 end]))
    ylim([0 1]);
    title ('signal vs. b-value (intra-axonal)')
    xlabel ('b-value')
end
