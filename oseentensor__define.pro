; docformat = 'rst'

;+
; Oseen tensor base class for describing hydrodynamic flows
; relative to specified positions.
;
; :Properties:
;    position
;        three-element array of Cartesian coordinates
;        specifying position of the source.
;    viscosity
;        viscosity of fluid in SI units.
;    tensor
;        3x3 array specifying the elements of the Oseen tensor.
;    radius
;        distance of closest approach.
;
; :Author:
;    David G. Grier, New York University.
;
; :Copyright:
;    Copyright (c) 2015 David G. Grier
;-

;+
; Check a provided vector to ensure that it has
; a compatible type are correct number of elements.
; Compute the displacement and separation from
; the source position.
;
; :Params:
;    r : in, required, type=`fltarr(3)`
;        Position in Cartesian cooardinates
;
; :Private:
;-
pro oseentensor::ComputeDisplacement, r

  COMPILE_OPT IDL2, HIDDEN

  if ~isa(r, /number, /array) then $
     message, 'r must be a numerical array'

  if (n_elements(r[*, 0]) ne 3) then $
     message, 'r must be a 3-element Cartesian coordinate'

  ; only support a single position for now
  if size(r, /n_dimensions) ne 1 then $
     message, 'only a single position is supported'

  self.dr = r - self.position
  self.r = sqrt(total(self.dr^2)) > self.radius
  self.dr /= self.r
end

;+
; Calculate the Oseen tensor at a specified position.
; 
; :Params:
;    r : in, required, type=`fltarr(3)`
;        Position in Cartesian coordinates.
;
; :Keywords:
;    inverse : in, optional, type=boolean
;        If set, return inverse of the Oseen tensor
;
; :Returns:
;    3x3 real-valued Oseen tensor
;-
function oseentensor::Compute, r, $
                               inverse = inverse

  COMPILE_OPT IDL2, HIDDEN

  self.Compute, r
  return, (keyword_set(inverse)) ? invert(self.tensor) : self.tensor
end

;+
; Calculate the Oseen tensor at a specified position.
; 
; :Params:
;    r : in, required, type=`fltarr(3)`
;        Position in Cartesian coordinates.
;-
pro oseentensor::Compute, r

  COMPILE_OPT IDL2, HIDDEN

  self.ComputeDisplacement, r
  self.tensor = identity(3)
end
     
;+
; oseentensor::SetProperty
;-
pro oseentensor::SetProperty, position = position, $
                              viscosity = viscosity, $
                              radius = radius

  COMPILE_OPT IDL2, HIDDEN

  if isa(position, /number, /array) && (n_elements(position) eq 3) then $
     self.position = float(position)

  if isa(viscosity, /number, /scalar) && (viscosity gt 0.) then $
     self.viscosity = float(viscosity)

  if isa(radius, /number, /scalar) && (radius gt 0.) then $
     self.radius = float(radius)
end

;+
; oseentensor::GetProperty
;-
pro oseentensor::GetProperty, tensor = tensor, $
                              position = position, $
                              viscosity = viscosity, $
                              radius = radius

  COMPILE_OPT IDL2, HIDDEN

  if arg_present(tensor) then tensor = self.tensor
  if arg_present(position) then position = self.position
  if arg_present(viscosity) then viscosity = self.viscosity
  if arg_present(radius) then radius = self.radius
end

;+
; oseentensor::Init()
;
; :Returns:
;    1 for success, 0 for failure
;
; :Keywords:
;    position : in, optional, type=`fltarr(3)`
;        Position of source in Cartesian coordinates.
;    viscosity : in, optional, type=`float`
;        Viscosity of medium.
;    radius: in, optional, type=`float`
;-
function oseentensor::Init, position = position, $
                            viscosity = viscosity, $
                            radius = radius

  COMPILE_OPT IDL2, HIDDEN

  self.tensor = identity(3)

  if isa(position, /number, /array) && (n_elements(position) eq 3) then $
     self.position = float(position)

  self.viscosity = isa(viscosity, /number, /scalar) ? $
                   float(viscosity) : $
                   0.001

  if isa(radius, /number, /scalar) && (radius gt 0.) then $
     self.radius = float(radius)

  return, (self.viscosity gt 0.)
end

;+
; oseentensor__define
;
; :Fields:
;    position
;        three-element array of Cartesian coordinates
;        specifying position of the source.
;    viscosity
;        viscosity of fluid in SI units.
;    tensor
;        3x3 array specifying the elements of the Oseen tensor.
;    radius
;        distance of closest approach.
;    dr
;        displacement of specified point from source position
;    r
;        separation of specified point from source position
;
; :Hidden:
;-
pro oseentensor__define

  COMPILE_OPT IDL2, HIDDEN

  struct = {oseentensor, $
            inherits IDL_Object, $
            tensor: fltarr(3, 3), $
            position: fltarr(3), $
            viscosity: 0., $
            radius: 0., $
            dr: fltarr(3),  $
            r: 0. $
           }
end
