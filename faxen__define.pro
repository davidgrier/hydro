; docformat = 'rst'

;+
; Calculate the velocity, $\vec{v}(\vec{r})$,
; of a sphere of radius $a$
; at position(s) $\vec{r}$ within a hydrodynamic flow,
; $\vec{u}(\vec{r})$.
;
; The velocity is computed according to
; Faxen's first law:
; $$\vec{v}(\vec{r}) = \vec{u}(\vec{r}) +
;                      \frac{a^2}{6} \, \nabla^2 \vec{u}$$
;
; :Properties:
;    radius
;        Radius of the sphere in meters.
;    flow
;        Object reference to a ```flowfield``` object
;        defining the hydrodynamic flow.
;
; :Author:
;    David G. Grier, New York University
;
; :Copyright:
;    Copyright (c) 2015 David G. Grier
;-

;+
; Calculate the velocity of the sphere at a specified
; set of points within the flow according to
; Faxen's first law:
; $$\vec{v}(\vec{r}) = \vec{u}(\vec{r}) +
;                      \frac{a^2}{6} \, \nabla^2 \vec{u}$$
;
; :Params:
;    r : in, required, type=fltarr(3,N)
;        Array of N Cartesian coordinates.
;-
function faxen::Compute, r

  COMPILE_OPT IDL2, HIDDEN

  npts = replicate(1., n_elements(r[0, *]))
  dx = [self.radius, 0., 0.] # npts
  dy = [0., self.radius, 0.] # npts
  dz = [0., 0., self.radius] # npts
  
  return, 2.*self.flow.compute(r) - $
          (self.flow.compute(r + dx) + $
           self.flow.compute(r - dx) + $
           self.flow.compute(r + dy) + $
           self.flow.compute(r - dy) + $
           self.flow.compute(r + dz) + $
           self.flow.compute(r - dz)) / 6.
end

;+
; faxen::SetProperty
;-
pro faxen::SetProperty, radius = radius, $
                        flow = flow

  COMPILE_OPT IDL2, HIDDEN

  if isa(radius, /number, /scalar) then $
     self.radius = float(radius)
  
  if isa(flow, 'flowfield') then $
     self.flow = flow

   if isa(flow, 'flowsource') then begin
     self.flow = flowfield()
     self.flow.add, flow
  endif
end

;+
; faxen::GetProperty
;-
pro faxen::GetProperty, radius = radius, $
                        flow = flow

  COMPILE_OPT IDL2, HIDDEN

  if arg_present(radius) then $
     radius = self.radius

  if arg_present(flow) then $
     flow = self.flow
end

;+
; faxen::Init()
;
; :Returns:
;    1 for success, 0 for failure
;
; :Keywords:
;    radius : in, optional, type=float
;        Radius of the sphere in meters.
;        Default: 1.
;    flow : in, optional, type=object
;        Object reference to a ```flowfield``` or ```flowsource```
;        responsible for the hydrodynamic flow around the sphere.
;-
function faxen::Init, radius = radius, $
                      flow = flow

  COMPILE_OPT IDL2, HIDDEN

  self.radius = isa(radius, /number, /scalar) ? $
                float(radius) : 1.

  if isa(flow, 'flowfield') then $
     self.flow = flow

  if isa(flow, 'flowsource') then begin
     self.flow = flowfield()
     self.flow.add, flow
  endif
  
  return, 1B
end
     
;+
; faxen_define
;
; :Fields:
;    radius
;        Radius of the sphere in meters.
;    flow
;        Object reference to a ```flowsource``` or ```flowfield```
;        that creates a hydrodynamic flow $\vec{u}(\vec{r})$ around the sphere.
;
; :Hidden:
;-
pro faxen__define

  COMPILE_OPT IDL2, HIDDEN

  struct = {faxen, $
            inherits IDL_Object, $
            radius: 0., $
            flow: obj_new() $
           }
end
