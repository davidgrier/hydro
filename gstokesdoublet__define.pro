; docformat = 'rst'

;+
; Oseen tensor for a stokes doublet oriented relative to the
; plane $z = 0$.
; $$\mathsf{G}_{\alpha \beta}(\vec{r})
;    =
;    \frac{1 - 2 \delta_{\beta z}}{8 \pi \eta} \,
;    \frac{\partial}{\partial r_\beta} \left(
;        \frac{r_\alpha}{r^3}
;    \right)
; $$
;
; Reference:
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
; 3. Josephine Ainley, Sandra Durkin, Rafael Embid, Priya Boindala
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
; Compute the Oseen tensor for a stokes doublet at a specified
; position.
;
; :Params:
;    r : in, required, type=`fltarr(3)`
;        Position in Cartesian coordinates.
;
; :Note: factor of 4 rather than 8? Ainley.
;-
pro Gstokesdoublet::Compute, r

  COMPILE_OPT IDL2, HIDDEN

  self.ComputeDisplacement, r
  self.tensor = (identity(3) - 3.*(self.dr # self.dr)) / $
                (8.*!pi*self.viscosity*self.r^3)
  self.tensor[*, 2] *= -1.
end

;+
; Gstokesdoublet__define
;
; :Hidden:
;-
pro Gstokesdoublet__define

  COMPILE_OPT IDL2, HIDDEN

  struct = {Gstokesdoublet, $
            inherits oseentensor $
           }
end
