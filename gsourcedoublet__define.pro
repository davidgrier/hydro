; docformat = 'rst'

;+
; Oseen tensor for a source doublet oriented relative to the
; plane $z = 0$.
; $$\mathsf{G}_{\alpha \beta}(\vec{r})
;    =
;    (1 - 2 \delta_{\beta z}) \,
;    \frac{\partial}{\partial r_\beta} \,
;    \mathsf{G}^\text{stokeslet}_{\alpha \beta}(\vec{r})
; $$
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
; :Params:
;    r : in, required, type=`fltarr(3)`
;        Position in Cartesian coordinates.
;-
pro Gsourcedoublet::Compute, r

  COMPILE_OPT IDL2, HIDDEN

  self.ComputeDisplacement, r
  self.tensor = self.dr # ([1., 1., 1.] - 3.*self.dr^2) / $
                (8.*!pi*self.viscosity*self.r^2)
  self.tensor[*, 2] *= -1.
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
