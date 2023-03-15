# Microstructure Simulations

This repository provides some Matlab code to run simple simulations of the MRI
signal that would be expected for restricted diffusion in cylinders, as a
surrogate model of diffusion in brain white matter. This is not really suitable
for full-blown simulations, and is intended for demonstration purposes only.

## Description

This assumes a substrate consisting of an infinite number of cylinders with a
fixed axonal radius, arranged in a hexagonal grid. A set number of _walkers_ is
randomly distributed and allowed to diffuse within this medium with a fixed
step size in a random orientation per time step:

$$
\mathbf{x}_n(t) = \mathbf{x}_n(t-1) + \epsilon \hat{\mathbf{u}} \qquad \textrm{with } \hat{\mathbf{u}} \sim \mathcal{U}
$$

Where $\mathcal{U}$ is the uniform probability density function over the unit sphere. 

During the simulation, the cumulative sum of the product of each walker's
position $\mathbf{x}_n(t)$ with the (unit amplitude) gradient timecourse
$\Gamma(t)$ is computed:

$$
\tilde{\mathbf{x}}_n = \sum_t \mathbf{x}_n(t) \Gamma(t)
$$

This can then be used to compute the diffusion MRI signal expected for any
gradient maximum amplitude $G$ and (unit) direction vector $\hat{\mathbf{g}}$:

$$
S = \frac{S_0}{N} \sum_n^N \exp\left( i \gamma G \\; \tilde{\mathbf{x}}_n \cdot \hat{\mathbf{g}}\right)
$$

where $\gamma$ is the gyromagnetic ratio of ¹H.

This formulation makes it possible to derive the signal for any combination of
_b_-value and gradient direction from a single simulation run, provided the
gradient timecourse remain constant. 


## Implementation

Refer to the
[`simulate.m`](https://github.com/jdtournier/microstructure_simulations/blob/main/simulate.m)
file for an example session.

### Basic parameters:

The parameters of the simulation are stored in a Matlab struct, which should
initially contains the following members:
```
param = 

  struct with fields:

             axon_radius: 0.9000
         axon_separation: 2
                       D: 3
             num_walkers: 2000
               step_size: 0.1000
```

- `axon_radius` & `axon_separation` should be provided in µm, and `axon_radius`
  must be less than ½ `axon_separation`.
- `D` is the bulk diffusion coefficient, provided in ms/µm² (3 for free water
  at 37°C).
- `num_walkers` is the number of molecules to include in the simulations, and
  should be set to a number large enough to obtain stable estimates, while
  remaining computationally feasible.
- `step_size` is the length of each random step, provided in µm. This  needs to
  be set to a value commensurate with the smallest gap in the structure.

### Gradient waveform:

The gradient waveform to simulate should be provided as a vector of amplitudes
(with unit maximum absolute value). For a regular pulsed-gradient spin-echo
sequence, you can use the `generate_PGSE_waveform()` call, which takes the
parameter struct and the gradient pulse duration $\delta$ and separation
$\Delta$ (in ms units), and returns an update version of that struct with the
waveform included, e.g.:
```
param = generate_PGSE_waveform (param, 20, 50); 
```
This will also work out the appropriate time step for the simulation based on
the `step_size` and the bulk diffusivity `D`:

$$
\delta t = \frac{\epsilon^2}{6 D}
$$

### Running the simulation:

Once the parameters have been set, the simulation can be run using the
`run_simulation()` call, with takes the parameter struct as its argument, and
optionally a boolean value if you wish to visualise the random walkers while
the simulation is ongoing (at the cost of an considerable increase in runtime):
```
param = run_simulation (param);
```
or if you wish to visualise the walkers:
```
param = run_simulation (param, true);
```
This returns an updated version of the parameter struct, with the cumulative
weighted positions $\\{ \tilde{\mathbf{x}}_n \\}$ included as an additional
field.


### Computing the dMRI signal:

Once the cumulative weighted positions $\\{ \tilde{\mathbf{x}}_n \\}$ have been
computed, the expected dMRI signal can be computed for any gradient direction
and amplitude, using the `compute_signal()` function, e.g.:
```
signal = compute_signals (param, gradient_directions, gradient_amplitudes); 
```
where:

- `gradient_directions` is a $3\times N$ matrix, with each row corresponding to
  a unit direction
- `gradient_amplitudes` is a vector of size $M$ for each gradient amplitude, in
  mT/m units. 

The signal will be computed for all combinations of $N$ directions and $M$
amplitudes, returned in the form of a $M \times N$ matrix of signal amplitudes. 



