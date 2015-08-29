; docstyle = 'rst'

;+
; Calculate the velocity of a sphere at position $\vec{r}$
; in a flow field $\vec{u}(\vec{r})$ subject to the
; constraint that it cannot pass through a horizontal surface
; in the plane $z = 0$.
;
; :Author:
;    David G. Grier, New York University
;
; :Copyright:
;    Copyright (c) 2015 David G. Grier
;-

;+
; Calculate the velocity of the sphere at a specified
; set of points within the flow, subject to the constraint
; that the sphere cannot pass through the plane.
;
; :Params:
;    r : in, required, type=`fltarr(3,N)`
;        Set of N Cartesian coordinates at which to calculate
;        the sphere's velocity.
;-
function boundedfaxen::Compute, r

  COMPILE_OPT IDL2, HIDDEN

  v = self.faxen::Compute(r)
  w = where(r[2, *] le 1.001*self.radius, /null)
  v[2, w] = 0.
  return, v
end

;+
; boundedfaxen__define
;
; :Hidden:
;-
pro boundedfaxen__define

  COMPILE_OPT IDL2, HIDDEN

  struct = {boundedfaxen, $
            inherits faxen $
           }
end
