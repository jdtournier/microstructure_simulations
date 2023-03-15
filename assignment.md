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
- axon radius = 0.9 µm
- axon separation = 2 µm
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
respectively, also known as the axial and radial diffusivities.
Plot their dependence as a function of _b_-value. Summarise and explain the main features of your result.

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

## 2.1 — Effect of packing density

Show what happens as the axon packing density changes, by varying the axon separation while holding the axon radius fixed. 
Set the axon radius to 1µm, and run simulations for axon separations of 2.1,
2.2, 2.5 & 3µm (holding all other parameters the same as in Part 1).
Note that you may find these take a lot longer, especially when the
axon diameter gets close to the axon separation, as the step size will get
smaller to adjust for the tighter geometry; nonetheless, on my laptop, the
slowest run completed within a few minutes. 

Plot the effect this has on:
- the dMRI signals along and across the axons,
- the estimated axial and radial diffusivities $D_\parallel$ and $D_\perp$,
- the corresponding MD & FA values
Summarise and explain the main features of your result.


## 2.2 — Effect of axon radius

Show what happens as the axon radius changes, by varying the axon radius while maintaining the ratio of axon radius to axon separation. 
Set the axon radius to 0.5, 1, 3 & 10µm, and set the axon separation to
2.2× the axon radius to maintain the same relative volume fractions (holding
all other parameters the same as in Part 1).
As before, you will find the simulations for the smaller axon radius take
longer to compute.

Plot the effect this has on:
- the dMRI signals along and across the axons,
- the estimated axial and radial diffusivities $D_\parallel$ and $D_\perp$,
- the corresponding MD & FA values
Summarise and explain the main features of your result.


# Part 3: Effect of gradient timings

Show what happens as the pulse duration changes, by varying $\delta$, holding
the $b$-value and effective diffusion time ($\Delta - \delta/3$) constant. 
Set the pulse duration to 1, 2, 5, 10 & 20ms, and the gradient amplitudes to
560, 280, 112, 56 & 28 mT/m, modifying $\Delta$ so that $\Delta - \delta/3$
remains constant. As part of your answer, verify that this results in the same
nominal $b$-value (close to 1 ms/µm²).


Plot the effect this has on:
- the dMRI signals along and across the axons,
- the estimated axial and radial diffusivities $D_\parallel$ and $D_\perp$,
- the corresponding MD & FA values
Summarise and explain the main features of your result.

