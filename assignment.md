# Diffusion MRI assignment: simulations of microstructure

_MIGEP52 — MSc/MRes in Healthcare Technologies (22~23) — Advanced MR Imaging_


---

For this assignment, you will need to download the code hosted on the
[microstructure
simulations](https://github.com/jdtournier/microstructure_simulations)
repository on GitHub. This contains MatLab code to perform simulations of
water diffusion in a simple model of brain white matter. 

[Click here](https://github.com/jdtournier/microstructure_simulations/archive/refs/heads/main.zip)
to download the code as a ZIP archive. \
Please familiarise yourself with the code by going through the
[README](https://github.com/jdtournier/microstructure_simulations/blob/main/README.md). 


Please also remember that this is an assessed exercise. You are welcome to discuss with your
fellow students, but your solutions must be your own.

# Part 1: General behaviour

Perform simulations for the following parameters:

- $\delta$ / $\Delta$ = 20 / 50 ms
- axon radius = 0.45 µm
- axon separation = 1 µm
- bulk diffusivity = 3 µm²/ms

Use the output of these simulations to investigate the following:

## 1.1 — Effect of gradient direction

Show what happens to the dMRI signal as the gradient direction sweeps from
parallel to perpendicular to the axons. Use the gradients of 0, 10, 20 and 40
mT/m. Summarise and explain the main features of your result.

## 1.2 — Effect of _b_-value

Show what happens to the dMRI signal as the _b_-value increases from zero to
the maximum achievable for the above sequence on a system with
$G_{\textrm{max}}$ = 40 mT/m, with the gradient applied perpendicular and
parallel to the axons. Summarise and explain the main features of your results.

## 1.3 — Impact on ADC, mean diffusivity and anistropy

Use your results from question 1.2 and the equation:

$$
S = S_0 e^{-bD}
$$

to compute $D_\parallel$ and $D_\perp$, the apparent diffusion coefficient (ADC) along and across the axons
respectively. Plot their dependence as a function of _b_-value. Summarise and explain the main features of your result.

Use these results and the equations:

$$
MD = ⅓D_\parallel + ⅔D_\perp
$$

$$
FA = \sqrt{\frac{3}{2} - \frac{(D_\parallel + 2D_\perp)^2}{2(D_\parallel^2 + 2D_\perp^2)} }
$$

To compute MD & FA, the mean diffusivity and fractional anistropy respectively. 
Plot their dependence as a function of _b_-value. 
Summarise and explain the main features of your result.

# Part 2: Effect of axonal geometry



# Part 3: Effect of gradient timings
