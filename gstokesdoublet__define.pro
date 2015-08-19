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
;-
pro Gstokesdoublet::Compute, r

  COMPILE_OPT IDL2, HIDDEN

  if ~(s = self.checkvector(r)) then begin
     self.tensor = identity(3)
     return
  endif

  dr = (r - self.position)/s    ; displacement from stokes doublet
  self.tensor = (identity(3) - 3.*(dr # dr))/(8.*!pi*self.viscosity*s^3)
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
