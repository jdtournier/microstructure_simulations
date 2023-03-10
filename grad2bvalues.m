function bvalues = grad2bvalues (gradient_amplitudes, gradient_duration, gradient_separation)

arguments
    gradient_amplitudes (1,:) double
    gradient_duration (1,1) double
    gradient_separation (1,1) double
end

bvalues = (2.68e8)^2 * gradient_amplitudes.^2 * gradient_duration^2 * (gradient_separation - gradient_duration/3) * 1e-15 * 1e-9;
