; docformat = 'rst'

;+
; Oseen tensor for a stokelet.
; $$\tensor{G}_{\alpha\beta}(\vec{r})
; =
; \frac{1}{8 \pi \eta} \,
; \left(
;    \frac{\delta_{\alpha\beta}}{r}
;    +
;    \frac{r_\alpha r_\beta}{r^3}
; \right)$$
;
; :Author:
;    David G. Grier, New York University
;
; :Copyright:
;    Copyright (c) 2015 David G. Grier
;-

;+
; Compute the Oseen tensor for a stokeslet at a specified position
;
; :Params:
;    r : in, required, type=`fltarr(3)`
;        Position of the stokeslet in Cartesian coordinates.
;-
pro Gstokeslet::Compute, r

  COMPILE_OPT IDL2, HIDDEN

  if ~self.checkvector(r) then begin
     self.tensor = identity(3)
     return
  endif
  
  rr = r - self.position        ; displacement from position of stokeslet
  s = sqrt(total(rr^2))         ; distance from stokeslet
  rr /= s
  self.tensor = (identity(3) + rr # rr)/(8.*!pi*self.viscosity*s)
end
  
;+
; Gstokeslet__define
;
; :Hidden:
;-
pro Gstokeslet__define

  COMPILE_OPT IDL2, HIDDEN

  struct = {Gstokeslet, $
            inherits oseentensor $
           }
end
