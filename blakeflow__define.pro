; docformat = 'rst'

;+
; Flow field at specified points due to a stokeslet near
; a horizontal wall in the plane $z = 0$.
;
; Reference:
; J. R. Blake, "A note on the image system for a stokeslet in
; a no-slip boundary," Proc. Cambridge Phil. Soc. 70, 303-310 (1971).
;
; :Author:
;    David G. Grier, New York University
;
; :Copyright:
;    Copyright (c) 2015 David G. Grier
;-

;+
; blakeflow::SetProperty
;
; :Keywords:
;    _extra : type=keywords
;        Properties of `flowsource` objects, appropriately
;        weighted for Blake's flow solution.
;-
pro blakeflow::SetProperty, _extra = extra

  COMPILE_OPT IDL2, HIDDEN

  stokeslet = self.sources[0]
  stokeslet.SetProperty, _extra = extra
  stokeslet.GetProperty, position = position, force = force, $
                         viscosity = eta

  rstar = position * [1., 1., -1.]
  fstar = force * [1., 1., -1.]
  h = position[2]
  
  (self.sources[1]).SetProperty, viscosity = eta, position = rstar, $
     force = -force

  (self.sources[2]).SetProperty, viscosity = eta, position = rstar, $
     orientation = fstar, force = 2.*h*[0., 0., 1.]*force

  (self.sources[3]).SetProperty, viscosity = eta, position = rstar, $
     force = -2.*h^2*fstar
end

;+
; blakeflow::GetProperty
;
; :Keywords:
;    sources : type=`list`
;        List of `flowsource` object references to the
;        elementary flow sources in Blake's formulation.
;    _ref_extra : type=keywords
;        Properties of the `Gstokeslet` `flowsource` object
;        responsible for the flow.
;-
pro blakeflow::GetProperty, sources = sources, $
                            _ref_extra = re

  COMPILE_OPT IDL2, HIDDEN

  if arg_present(sources) then $
     sources = self.sources
  
  (self.sources[0]).GetProperty, _extra = re
end

;+
; blakeflow::Init()
;
; :Returns:
;    1 for success, 0 for failure
;
; :Keywords:
;    position : in, optional, type=`fltarr(3)`
;        3-element position vector
;    _ref_extra : in, optional, type=keywords
;        Properties of the `Gstokeslet` `flowsource` object
;        responsible for the flow.
;-
function blakeflow::Init, position = position, $
                          _ref_extra = extra 

  COMPILE_OPT IDL2, HIDDEN

  if ~self.flowfield::Init() then $
     return, 0
  
  src = flowsource(Gstokeslet(position = position, _extra = extra), $
                   _extra = extra)

  force = src.force
  rstar = position * [1., 1., -1.]
  fstar = force * [1., 1., -1.]
  h = position[2]
  
  self.add, src
  
  self.add, flowsource(Gstokeslet(position = rstar, $
                                  _extra = extra), $
                       force = -force)

  self.add, flowsource(Gstokesletdipole(position = rstar, $
                                        orientation = fstar, $
                                        _extra = extra), $
                       force = 2.*h*[0., 0., 1.]*force)

  self.add, flowsource(Gsourcedoublet(position = rstar, $
                                      _extra = extra), $
                       force = -2.*h^2*fstar)
  return, 1
end

;+
; blakeflow__define
;
; :Hidden:
;-
pro blakeflow__define

  COMPILE_OPT IDL2, HIDDEN

  struct = {blakeflow, $
            inherits flowfield $
           }
end
