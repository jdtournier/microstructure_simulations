# Diffusion MRI assignment: simulations of microstructure

_MIGEP52 — MSc/MRes in Healthcare Technologies (22~23) — Advanced MR Imaging_


---

For this assignment, you will need to download the code hosted on the
[microstructure
simulations](https://github.com/jdtournier/microstructure_simulations)
repository on GitHub. This contains MatLab code to perform simulations of
water diffusion in a simple model of brain white matter, and computes the
diffusion MRI signal that would be expected for an arbitrary set of diffusion
gradient directions and amplitudes. 

[Click here](https://github.com/jdtournier/microstructure_simulations/archive/refs/heads/main.zip)
to download the code as a ZIP archive. \
Please familiarise yourself with the code by going through the
[README](https://github.com/jdtournier/microstructure_simulations/blob/main/README.md). 


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

which can be inverted to give:

$$
D = - \frac{1}{b} \ln \left( \frac{S}{S_0} \right)
$$

to compute $D_\parallel$ and $D_\perp$, the apparent diffusion coefficient (ADC) along and across the axons
respectively, also known as the axial and radial diffusivities.
Plot their dependence as a function of _b_-value. Summarise and explain the main features of your result.

Use these results to compute the mean diffusivity MD:

$$
MD = ⅓D_\parallel + ⅔D_\perp
$$

and a simplified measure of anisotropy, based on the ratio between radial and
axial diffusivities (it would be better to use the fractional anisotropy, but
its calculation is needlessly complex for this assignment, and this measure is a close enough
approximation):

$$
A = 1 - \frac{D_\perp}{D_\parallel}
$$

Plot the dependence of mean diffusivity and anisotropy as a function of _b_-value. 
Summarise and explain the main features of your result.


## 1.4 — Effect of packing density

Holding all other parameters fixed, set the axon separation to 3µm, and produce
the same plots as for question 1.3 to show the effect this has on axial &
radial diffusivity, mean diffusivity, and anisotropy.

Summarise and explain the main features of your results.


## 1.5 — Effect of axon radius

Holding all other parameters fixed, set the axon radius to 9µm, and the axon
separation to 20µm, and produce the same plots as for question 1.3 to show
the effect this has on axial & radial diffusivity, mean diffusivity, and
anisotropy.

Summarise and explain the main features of your results.
