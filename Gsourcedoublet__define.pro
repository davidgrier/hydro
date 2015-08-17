; docformat = 'rst'

;+
; Oseen tensor for a source doublet oriented relative to the
; plane z = 0
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
;    r : in, required, type=fltarr
;        3-element position vector
;-
pro Gsourcedoublet::Compute, r

  COMPILE_OPT IDL2, HIDDEN

  if ~self.checkvector(r) then begin
     self.tensor = identity(3)
     return
  endif

  rr = r - self.position        ; displacement from position of source doublet
  s = sqrt(total(rr^2))          ; distance from source doublet
  rr /= s
  self.tensor = rr # ([1., 1., 1.] - 3.*rr^2) / (8.*!pi*self.viscosity*s^2)
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
