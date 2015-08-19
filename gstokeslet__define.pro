; docformat = 'rst'

;+
; Oseen tensor for a stokelet.
; $$\mathsf{G}_{\alpha\beta}(\vec{r})
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
;        Position in Cartesian coordinates.
;-
pro Gstokeslet::Compute, r

  COMPILE_OPT IDL2, HIDDEN

  if ~(s = self.checkvector(r)) then begin
     self.tensor = identity(3)
     return
  endif
  
  dr = (r - self.position)/s    ; displacement from stokeslet
  self.tensor = (identity(3) + dr # dr)/(8.*!pi*self.viscosity*s)
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
