; docformat = 'rst'

;+
; Base class for calculating the mobility tensor of an object
; at position $\vec{r}$ in a fluid of viscosity $\eta$.
;
; :Author:
;    David G. Grier, New York University
;
; :Copyright:
;    Copyright (c) 2015 David G. Grier
;-

;+
; Calculate and return the mobility at $\vec{r}$.
;
; :Params:
;    r : in, optional, type=`fltarr(3)`
;        Postion of object in Cartesian coordinates [m]
;-
function mobility::Compute, r

  COMPILE_OPT IDL2, HIDDEN

  self.compute, r
  return, self.tensor
end

;+
; Calculate the mobility at position $\vec{r}$.
;
; :Params:
;    r : in, optional, type=`fltarr(3)`
;        Postion of object in Cartesian coordinates [m]
;-
pro mobility::Compute, r

  COMPILE_OPT IDL2, HIDDEN

  self.tensor = identity(3)
end
  
;+
; mobility::SetProperty
;-
pro mobility::SetProperty, viscosity = viscosity

  COMPILE_OPT IDL2, HIDDEN

  if isa(viscosity, /number, /scalar) then $
     self.viscosity = float(viscosity)
end

;+
; mobility::GetProperty
;-
pro mobility::GetProperty, tensor = tensor, $
                           viscosity = viscosity

  COMPILE_OPT IDL2, HIDDEN

  if arg_present(tensor) then tensor = self.tensor
  if arg_present(viscosity) then viscosity = self.viscosity
end

;+
; mobility::Init()
;
; :Keywords:
;    viscosity: in, optional, type=float, default=0.001
;        Viscosity of medium.
;
; :Returns:
;    1 for success, 0 for failure
;
; :Keywords:
;    viscosity: in, optional, type=float, default=0.001
;        Viscosity of medium.
;-
function mobility::Init, viscosity = viscosity

  COMPILE_OPT IDL2, HIDDEN

  self.tensor = identity(3)

  self.viscosity = isa(viscosity, /number, /scalar) ? $
                   float(viscosity) : $
                   0.001

  return, 1
end

;+
; mobility__define
;
; :Fields:
;    tensor: type=`fltarr(3,3)`
;        mobility tensor
;    viscosity: type=float
;        viscosity of fluid in SI units.
;
; :Hidden:
;-
pro mobility__define

  COMPILE_OPT IDL2, HIDDEN

  struct = {mobility, $
            inherits IDL_Object, $
            tensor: fltarr(3, 3), $
            viscosity: 0. $
           }
end
