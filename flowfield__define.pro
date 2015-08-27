; docformat = 'rst'

;+
; Flow field $\vec{u}(\vec{r})$
; at specified points $\vec{r}$ due to a set of flow sources.
;
; :Properties:
;    sources: list of references to `flowsource` objects.
;
; :Author:
;    David G. Grier, New York University
;
; :Copyright:
;    Copyright (c) 2015 David G. Grier
;-

;+
; Calculate the flow velocity $\vec{u}(\vec{r})$
; at positions $\vec{r}$ due to the
; specified set of sources.
;
; :Params:
;    r : in, required, type=`fltarr(3,N)`
;        Array of N sets of Cartesian coordinates, $\vec{r}$.
;
; :Keywords:
;    _extra : in, optional, type=keywords
;        Keywords for the Compute() method of the
;        `flowsource` object.
;
; :Returns:
;    3xN element array of velocity vectors, $\vec{u}(\vec{r})$.
;-
function flowfield::Compute, r, $
                             _extra = extra

  COMPILE_OPT IDL2, HIDDEN

  npts = n_elements(r)/3.
  v = 0.*r
  foreach source, self.sources do $
     v += source.compute(r, _extra = extra)

  return, v
end

;+
; Add a `flowsource` object to the list of sources.
;
; :Params:
;    source : in, required, type=`flowsource`
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
;        list of references to `flowsource` objects.
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
