; docformat = 'rst'

;+
; Oseen tensor for a stokes doublet oriented relative to the
; plane $z = 0$.
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
;    r : in, required, type=fltarr(3)
;        Position of the stokes doublet in Cartesian coordinates.
;-
pro Gstokesdoublet::Compute, r

  COMPILE_OPT IDL2, HIDDEN

  if ~self.checkvector(r) then begin
     self.tensor = identity(3)
     return
  endif

  rr = r - self.position        ; displacement from position of stokes doublet
  s = sqrt(total(rr^2))         ; distance from stokes doublet
  rr /= s
  self.tensor = (identity(3) - 3.*(rr # rr))/(8.*!pi*self.viscosity*s^3)
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
