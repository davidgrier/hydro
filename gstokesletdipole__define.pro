; docformat = 'rst'

;+
; Oseen tensor for a stokeslet dipole oriented along direction $\hat{d}$.
;
; $$ \mathsf{G_D}_{\alpha\beta}(\vec{r},\hat{d})
;    =
;    \frac{1}{8 \pi \eta r^3} \,
;    \left[
;        (\hat{d} \cdot \vec{r})
;        \left(
;            \delta_{\alpha\beta}
;            + 3 \frac{r_\alpha r_\beta}{r^2}
;        \right)
;        - (r_\alpha d_\beta + r_\beta d_\alpha)
;    \right]
; $$
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
; Compute the Oseen tensor for a stokeslet dipole at a specified
; position.
;
; :Params:
;    r : in, required, type=`fltarr(3)`
;        Position in Cartesian coordinates.
;-
pro Gstokesletdipole::Compute, r

  COMPILE_OPT IDL2, HIDDEN

  self.ComputeDisplacement, r
  self.tensor = (total(self.orientation * self.dr) * $
                 (identity(3) + 3.*self.dr # self.dr) - $
                 (self.dr#self.orientation + self.orientation#self.dr)) / $
                (8.*!pi*self.viscosity*self.r^2)
end

;+
; Gstokesletdipole::GetProperty
;-
pro Gstokesletdipole::GetProperty, orientation = orientation, $
                                   _ref_extra = ex

  COMPILE_OPT IDL2, HIDDEN

  if arg_present(orientation) then $
     orientation = self.orientation

  self.oseentensor::GetProperty, _extra = ex
end

;+
; Gstokesletdipole::SetProperty
;-
pro Gstokesletdipole::SetProperty, orientation = orientation, $
                                   _extra = ex

  COMPILE_OPT IDL2, HIDDEN

  if isa(orientation, /number, /array) && (n_elements(orientation) eq 3) then $
     self.orientation = float(orientation)/norm(orientation)

  self.oseentensor::SetProperty, _extra = ex
end

;+
; Gstokesletdipole::Init()
;
; :Hidden:
;-
function Gstokesletdipole::Init, orientation = orientation, $
                                 _extra = ex

  COMPILE_OPT IDL2, HIDDEN

  if isa(orientation, /number, /array) && (n_elements(orientation) eq 3) then $
     self.orientation = float(orientation)/norm(orientation) $
  else $
     self.orientation = [0., 0., 1.]

  return, self.oseentensor::Init(_extra = ex)
end

;+
; Gstokesletdipole__define
;
; :Hidden:
;-
pro Gstokesletdipole__define

  COMPILE_OPT IDL2, HIDDEN

  struct = {Gstokesletdipole, $
            inherits oseentensor, $
            orientation: fltarr(3) $
           }
end
