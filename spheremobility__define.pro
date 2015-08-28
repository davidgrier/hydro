; docformat = 'rst'

;+
; Mobility tensor for a sphere in a Newtonian fluid.
;
; :Author:
;    David G. Grier, New York University
;
; :Copyright:
;    Copyright (c) 2015 David G. Grier
;-

;+
; Calculate the mobility of the sphere.
;
; :Params:
;    r : in, optional, type=`fltarr(3)`
;        Postion of sphere in Cartesian coordinates [m]
;-
pro spheremobility::Compute, r

  COMPILE_OPT IDL2, HIDDEN

  self.mobility::Compute
  self.tensor /= (6.*!const.pi*self.viscosity*self.radius)
end

;+
; spheremobility::SetProperty
;-
pro spheremobility::SetProperty, radius = radius, $
                                 _ref_extra = extra

  COMPILE_OPT IDL2, HIDDEN

  if isa(radius, /number, /scalar) then $
     self.radius = float(radius)

  self.mobility::SetProperty, _extra = extra
end

;+
; spheremobility::GetProperty
;-
pro spheremobility::GetProperty, radius = radius, $
                                 _ref_extra = extra

  COMPILE_OPT IDL2, HIDDEN

  self.mobility::GetProperty, _extra = extra

  if arg_present(radius) then radius = self.radius
end

;+
; spheremobility::Init()
;
; :Keywords:
;    radius: in, optional, type=float, default=1.
;        Radius of sphere [m].
;    _extra: in, optional, type=keywords
;        Keywords for `mobility` tensor.
;
; :Returns:
;    1 for success, 0 for failure
;-
function spheremobility::Init, radius = radius, $
                               _extra = extra

  COMPILE_OPT IDL2, HIDDEN

  void = self.mobility::Init(_extra = extra)

  self.radius = isa(radius, /number, /scalar) ? $
                float(radius) : 1.

  return, 1
end

;+
; spheremobility__define
;
; :Fields:
;    radius: type=float
;        radius of sphere [m]
;
; :Hidden:
;-
pro spheremobility__define

  COMPILE_OPT IDL2, HIDDEN

  struct = {spheremobility, $
            inherits mobility, $
            radius: 0. $
           }
end
