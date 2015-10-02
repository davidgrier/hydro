; docformat = 'rst'

;+
; Flow field $\vec{u}(\vec{r})$ at $\vec{r}$ due to a point force
; $\vec{f}$ acting at position $\vec{r}_0$
; near a horizontal wall in the plane $z = 0$.
;
; $$ \vec{v}(\vec{r}) =
;    \mathsf{G}(\vec{s}) \cdot \vec{f}
;    - \mathsf{G}(\vec{s}^\ast) \cdot \vec{f}
;    + 2 z_0 \mathsf{G_D}(\vec{s}^\ast, \hat{e}^\ast) \cdot f \hat{z}
;    - 2 z_0^2 \mathsf{D}(\vec{s}^\ast) \cdot \vec{f}^\ast,
; $$
; where $\vec{s} = \vec{r} - \vec{r}_0$,
; $\vec{s}^\ast = \vec{s} - 2 z_0 \hat{z}$, and
; $\hat{e}^\ast = e_x \hat{x} + e_y \hat{y} - e_z \hat{z}$, and
; $\vec{f}^\ast = f \hat{e}^\ast$.
;
; $\mathsf{G}(\vec{r})$ is the Oseen tensor for a stokeslet,
; $\mathsf{G_D}(\vec{r},\hat{d})$ is the Oseen tensor for a stokeslet
; dipole oriented in direction $\hat{d}$, and
; $\mathsf{D}(\vec{r})$ is the Oseen tensor for a source doublet.
;
; References:
;
; 1. J. R. Blake,
;    "A Note on the image system for a Stokeslet in a no-slip
;    boundary,"
;    Proceedings of the Cambridge Philosophical Society 70, 303
;    (1971).
;
; 2. C. Pozrikidis,
;    Introduction to Theoretical and Computational Fluid Dynamics
;    (Oxford University Press, 1997).
;
; 3. Saverio E. Spagnolie and Eric Lauga,
;    "Hydrodynamics of self-propulsion near a boundary: predictions and
;    accurate far-field approximations,"
;    Journal of Fluid Mechanics 700, 105-147 (2012).
;
; 4. Josephine Ainley, Sandra Durkin, Rafael Embid, Priya Boindala
;    and Ricardo Cortez,
;    "The method of images for regularized Stokeslets,"
;    Journal of Computational Physics 227, 4600-4616 (2008).
;
; :Author:
;    David G. Grier, New York University
;
; :Copyright:
;    Copyright (c) 2015 David G. Grier
;-

;+
; blakeflow::SetProperty
;
; :Keywords:
;    _extra : type=keywords
;        Properties of `flowsource` objects, appropriately
;        weighted for Blake's flow solution.
;-
pro blakeflow::SetProperty, _extra = extra

  COMPILE_OPT IDL2, HIDDEN

  stokeslet = self.sources[0]
  stokeslet.SetProperty, _extra = extra
  stokeslet.GetProperty, position = position, force = force, $
                         viscosity = eta

  rstar = position * [1., 1., -1.]
  fstar = force * [1., 1., -1.]
  h = position[2]
  
  (self.sources[1]).SetProperty, viscosity = eta, position = rstar, $
     force = -force

  (self.sources[2]).SetProperty, viscosity = eta, position = rstar, $
     orientation = fstar, force = 2.*h*norm(force)*[0., 0., 1.]

  (self.sources[3]).SetProperty, viscosity = eta, position = rstar, $
     force = -2.*h^2*fstar
end

;+
; blakeflow::GetProperty
;
; :Keywords:
;    sources : type=`list`
;        List of `flowsource` object references to the
;        elementary flow sources in Blake's formulation.
;    _ref_extra : type=keywords
;        Properties of the `Gstokeslet` `flowsource` object
;        responsible for the flow.
;-
pro blakeflow::GetProperty, sources = sources, $
                            _ref_extra = re

  COMPILE_OPT IDL2, HIDDEN

  if arg_present(sources) then $
     sources = self.sources
  
  (self.sources[0]).GetProperty, _extra = re
end

;+
; blakeflow::Init()
;
; :Returns:
;    1 for success, 0 for failure
;
; :Keywords:
;    position : in, optional, type=`fltarr(3)`
;        3-element position vector
;    _ref_extra : in, optional, type=keywords
;        Properties of the `Gstokeslet` `flowsource` object
;        responsible for the flow.
;-
function blakeflow::Init, position = position, $
                          _ref_extra = extra 

  COMPILE_OPT IDL2, HIDDEN

  if ~self.flowfield::Init() then $
     return, 0

  src = flowsource(Gstokeslet(position = position, _extra = extra), $
                   _extra = extra)

  force = src.force
  rstar = position * [1., 1., -1.]
  fstar = force * [1., 1., -1.]
  h = position[2]
  
  self.add, src
  
  self.add, flowsource(Gstokeslet(position = rstar, $
                                  _extra = extra), $
                       force = -force)

  self.add, flowsource(Gstokesletdipole(position = rstar, $
                                        orientation = fstar, $
                                        _extra = extra), $
                       force = 2.*h*norm(force)*[0., 0., 1.])

  self.add, flowsource(Gsourcedoublet(position = rstar, $
                                      _extra = extra), $
                       force = -2.*h^2*fstar)
  return, 1
end

;+
; blakeflow__define
;
; :Hidden:
;-
pro blakeflow__define

  COMPILE_OPT IDL2, HIDDEN

  struct = {blakeflow, $
            inherits flowfield $
           }
end
