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
;
; :Private:
;-
function oseentensor::CheckVector, r

  COMPILE_OPT IDL2, HIDDEN

  if ~isa(r, /number, /array) then $
     return, 0

  if (n_elements(r[*, 0]) ne 3) then $
     return, 0

  ndim = size(r, /n_dimensions)

  return, (ndim eq 1) ? ndim : 0  ; only support single position for now
end

;+
; Calculate the Oseen tensor at a specified position.
; 
; :Params:
;    r : in, required, type=`fltarr(3)`
;        Position in Cartesian coordinates.
;
; :Returns:
;    3x3 real-valued Oseen tensor
;-
function oseentensor::Compute, r

  COMPILE_OPT IDL2, HIDDEN

  self.Compute, r
  return, self.tensor
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

  self.tensor = identity(3)
end
     
;+
; oseentensor::SetProperty
;-
pro oseentensor::SetProperty, position = position, $
                              viscosity = viscosity

  COMPILE_OPT IDL2, HIDDEN

  if isa(position, /number, /array) && (n_elements(position) eq 3) then $
     self.position = float(position)

  if isa(viscosity, /number, /scalar) && (viscosity gt 0.) then $
     self.viscosity = float(viscosity)
end

;+
; oseentensor::GetProperty
;-
pro oseentensor::GetProperty, tensor = tensor, $
                              position = position, $
                              viscosity = viscosity

  COMPILE_OPT IDL2, HIDDEN

  if arg_present(tensor) then tensor = self.tensor
  if arg_present(position) then position = self.position
  if arg_present(viscosity) then viscosity = self.viscosity
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
;-
function oseentensor::Init, position = position, $
                            viscosity = viscosity

  COMPILE_OPT IDL2, HIDDEN

  self.tensor = identity(3)

  if isa(position, /number, /array) && (n_elements(position) eq 3) then $
     self.position = float(position)

  self.viscosity = isa(viscosity, /number, /scalar) ? $
                   float(viscosity) : $
                   0.001

  return, (self.viscosity gt 0.)
end

;+
; oseentensor__define
;
; :Fields:
;   position
;        three-element array of Cartesian coordinates
;        specifying position of the source.
;    viscosity
;        viscosity of fluid in SI units.
;    tensor
;        3x3 array specifying the elements of the Oseen tensor.
;
; :Hidden:
;-
pro oseentensor__define

  COMPILE_OPT IDL2, HIDDEN

  struct = {oseentensor, $
            inherits IDL_Object, $
            tensor: fltarr(3, 3), $
            position: fltarr(3), $
            viscosity: 0. $
           }
end
