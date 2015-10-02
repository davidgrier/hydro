; docformat = 'rst'

;+
; Oseen tensor for a source doublet, also known as a potential doublet.
;
; $$ \mathsf{D}_{\alpha \beta}(\vec{r})
;    =
;    \frac{1}{8 \pi \eta r} \,
;    \left(
;        -\delta_{\alpha\beta}
;        + 3 \frac{r_\alpha r_\beta}{r^2}
;    \right)
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
; Compute the Oseen tensor for a source doublet at a specified
; position.
;
; :Note: Spagnolie & Lauga, Eq. (A8).
;
; :Params:
;    r : in, required, type=`fltarr(3)`
;        Position in Cartesian coordinates.
;-
pro Gsourcedoublet::Compute, r

  COMPILE_OPT IDL2, HIDDEN

  self.ComputeDisplacement, r
  self.tensor = (-identity(3) + 3.*(self.dr # self.dr)) / $
                (8.*!pi*self.viscosity*self.r^3)
end

;+
; Gsourcedoublet__define
;
; :Hidden:
;-
pro Gsourcedoublet__define

  COMPILE_OPT IDL2, HIDDEN

  struct = {Gsourcedoublet, $
            inherits oseentensor $
           }
end
