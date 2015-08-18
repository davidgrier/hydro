; docformat = 'rst'

;+
; Flow field at specified points due to a localized source
; of flow consisting of an Oseen tensor and a driving force.
;
; :Properties:
;    oseentensor
;        Object reference to the Oseen tensor describing the source.
;    force
;        3-element vector describing the force responsible for the flow.
;
; :Author:
;    David G. Grier, New York University
;
; :Copyright:
;    Copyright (c) 2015 David G. Grier
;-

;+
; Calculate the flow velocity at r due to the specified source.
;
; :Params:
;    r : in, required, type=fltarr
;        3xN element array of coordinates
;
; :Returns:
;    3-element velocity vector
;-
function flowsource::Compute, r

  COMPILE_OPT IDL2, HIDDEN

  if n_elements(r[*, 0]) ne 3 then $
     return, [0, 0, 0]
  
  npts = n_elements(r) / 3
  v = 0.*r
  for i = 0, npts-1 do $
     v[*, i] = self.oseentensor.compute(r[*, i]) # self.force
  return, v
end

;+
; flowsource::SetProperty
;-
pro flowsource::SetProperty, force = force, $
                             _extra = re

  COMPILE_OPT IDL2, HIDDEN

  if isa(force, /number, /array) && n_elements(force) eq 3 then $
     self.force = float(force)

  self.oseentensor.Setproperty, _extra = re
end

;+
; flowsource::GetProperty
;-
pro flowsource::GetProperty, force = force, $
                            _ref_extra = re

  COMPILE_OPT IDL2, HIDDEN

  if arg_present(force) then force = self.force

  self.oseentensor.Getproperty, _extra = re
end

;+
; flowsource::Init(oseentensor)
;
; :Returns:
;    1 for success, 0 for failure
;
; :Params:
;    oseentensor
;        Oseen tensor object reference for source.
;
; :Keywords:
;    force : in, optional, type=keyword
;        3-element force vector in units of newtons
;    extra : in, optional, type=keyword
;        Keywords for the Oseen tensor
;-
function flowsource::Init, oseentensor, $
                           force = force, $
                           _ref_extra = re

  COMPILE_OPT IDL2, HIDDEN

  if isa(oseentensor, 'oseentensor') then begin
     self.oseentensor = oseentensor
     self.oseentensor.setproperty, _extra = re
  endif else $
     self.oseentensor = oseentensor(_extra = re)
  
  if isa(force, /number, /array) && n_elements(force) eq 3 then $
     self.force = float(force) $
  else $
     self.force = [0., 0., 1.]

  return, 1B
end

;+
; flowsource__define
;
; :Fields:
;    oseentensor
;        Object reference to an Oseen tensor describing the
;        flow source.
;    force
;        3-element array describing force creating the flow
;        at the source.
;
; :Hidden:
;-
pro flowsource__define

  COMPILE_OPT IDL2, HIDDEN

  struct = {flowsource, $
            inherits IDL_Object, $
            oseentensor: obj_new(), $
            force: findgen(3) $
           }
end
