; docformat = 'rst'

;+
; Mobility tensor for a sphere at position $\vec{r}$
; moving relative to
; a solid plane wall that is located in the
; horizontal plane $z = 0$.
;
; Reference:
; J. Happel and H. Brenner,
; Low Reynolds Number Hydrodynamics
; (Kluwer Academic Publishers, Boston, 1991)
;
; Eq. (7-4.28) parallel case
;
; Eq. (7-4.39) perpendicular case
;
; :Author:
;    David G. Grier, New York University
;
; :Copyright:
;    Copyright (c) 2015 David G. Grier
;-

;+
; spherewallmobility::Compute
;
; :Params:
;    r : in, required, type=`fltarr(3)`
;        Position of sphere in Cartesian coordinates [m].
;-
pro spherewallmobility::Compute, r

  COMPILE_OPT IDL2, HIDDEN

  self.spheremobility::Compute

  if ~isa(r, /number, /array) then begin
     message, 'usage: Compute(r)', /inf
     return
  endif
  
  xi = self.radius/r[2] > 0. < 1.
  fac = 1. - (9./16.)*xi + xi^3/8. - (45./256.)*xi^4 - xi^5/16.
  self.tensor[[0, 4]] *= fac
  self.tensor[8] *= 1. - (9./8.)*xi + xi^4/2.
end

;+
; spherewallmobility__define
;
; :Hidden:
;-
pro spherewallmobility__define

  COMPILE_OPT IDL2, HIDDEN

  struct = {spherewallmobility, $
            inherits spheremobility $            
           }
end
