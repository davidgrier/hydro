; docformat = 'rst'

;+
; Oseen tensor for a stokeslet dipole oriented relative to the
; plane $z = 0$.
;
; :Author:
;    David G. Grier, New York University
;
; :Copyright:
;    Copyright (c) 2015 David G. Grier
;-

;+
; Compute the Oseen tensor for a stokeslet dipole at a specified
; position.
;
; :Params:
;    r : in, required, type=`fltarr(3)`
;        Position in Cartesian coordinates.
;-
pro Gstokesletdipole::Compute, r

  COMPILE_OPT IDL2, HIDDEN

  self.ComputeDisplacement, r
  self.tensor = (total(self.orientation * self.dr) * $
                 (identity(3) + 3.*self.dr # self.dr) - $
                 (self.dr#self.orientation + self.orientation#self.dr)) / $
                (8.*!pi*self.viscosity*self.r^2)
end

;+
; Gstokesletdipole::GetProperty
;-
pro Gstokesletdipole::GetProperty, orientation = orientation, $
                                   _ref_extra = ex

  COMPILE_OPT IDL2, HIDDEN

  if arg_present(orientation) then $
     orientation = self.orientation

  self.oseentensor::GetProperty, _extra = ex
end

;+
; Gstokesletdipole::SetProperty
;-
pro Gstokesletdipole::SetProperty, orientation = orientation, $
                                   _extra = ex

  COMPILE_OPT IDL2, HIDDEN

  if isa(orientation, /number, /array) && (n_elements(orientation) eq 3) then $
     self.orientation = float(orientation)/sqrt(total(orientation^2))

  self.oseentensor::SetProperty, _extra = ex
end

;+
; Gstokesletdipole::Init()
;
; :Hidden:
;-
function Gstokesletdipole::Init, orientation = orientation, $
                                 _extra = ex

  COMPILE_OPT IDL2, HIDDEN

  if isa(orientation, /number, /array) && (n_elements(orientation) eq 3) then $
     self.orientation = float(orientation)/sqrt(total(orientation^2)) $
  else $
     self.orientation = [0., 0., 1.]

  return, self.oseentensor::Init(_extra = ex)
end

;+
; Gstokesletdipole__define
;
; :Hidden:
;-
pro Gstokesletdipole__define

  COMPILE_OPT IDL2, HIDDEN

  struct = {Gstokesletdipole, $
            inherits oseentensor, $
            orientation: fltarr(3) $
           }
end
