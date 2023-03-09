function plot_walkers (X, assignments, lim, figure_handle)

arguments
    X (3,:) double
    assignments (2,:) double
    lim (1,1) double = 10
    figure_handle (1,1) double = 1
end

persistent plot_handle1
persistent plot_handle2

if isempty(plot_handle1) || ~isgraphics (plot_handle1)
    figure (figure_handle)

    m=find(isnan(assignments(1,:)));
    plot_handle1 = plot3(X(1,m), X(2,m), X(3,m), 'k.');
    hold on
    m=find(~isnan(assignments(1,:)));
    plot_handle2 = plot3(X(1,m), X(2,m), X(3,m), 'r.');
    hold off
    xlim(lim*[-1 1])
    ylim(lim*[-1 1])
    zlim(lim*[-1 1])
    axis vis3d;
    daspect([1 1 1]);
    box on
    set (gca, 'XLimMode', 'manual', ...
        'YLimMode', 'manual', ...
        'ZLimMode', 'manual');
    campos([0 0 10*lim])
    camup([0 1 0])

    return
else
    m=find(isnan(assignments(1,:)));
    set(plot_handle1, 'XData', X(1,m), 'YData', X(2,m), 'ZData', X(3,m));
    m=find(~isnan(assignments(1,:)));
    set(plot_handle2, 'XData', X(1,m), 'YData', X(2,m), 'ZData', X(3,m));
    drawnow;
end
