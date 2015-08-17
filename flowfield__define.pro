; docformat = 'rst'

;+
; Flow field at specified points due to a set of flow sources.
;
; :Properties:
;    sources: ordered list of object references to flow sources
;
; :Author:
;    David G. Grier, New York University
;
; :Copyright:
;    Copyright (c) 2015 David G. Grier
;-

;+
; Calculate the flow velocity at positions r due to the
; specified set of sources.
;
; :Params:
;    r : in, required, type=fltarr
;        3xN element array of coordinates
;
; :Returns:
;    3xN element array of velocity vectors
;-
function flowfield::Compute, r

  COMPILE_OPT IDL2, HIDDEN

  npts = n_elements(r)/3.
  v = 0.*r
  foreach source, self.sources do $
     v += source.compute(r)

  return, v
end

;+
; Add a flow source to the list of sources.
;
; :Params:
;    source : in, required, type=flowsource()
;-
pro flowfield::Add, source

  COMPILE_OPT IDL2, HIDDEN

  if isa(source, 'flowsource') then $
     self.sources.add, source
end

;+
; flowfield::Init()
;
; :Returns:
;    1 for success, 0 for failure
;-
function flowfield::Init

  COMPILE_OPT IDL2, HIDDEN

  self.sources = list()
  return, 1B
end

;+
; flowfield__define
;
; :Fields:
;    sources
;        ordered list of object references to flow sources.
;
; :Hidden:
;-
pro flowfield__define

  COMPILE_OPT IDL2, HIDDEN

  struct = {flowfield, $
            inherits IDL_Object, $
            sources: obj_new() $
           }
end
