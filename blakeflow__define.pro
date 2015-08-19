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
;-
pro blakeflow::SetProperty, _extra = extra

  COMPILE_OPT IDL2, HIDDEN

  stokeslet = self.sources[0]
  stokeslet.SetProperty, _extra = extra
  stokeslet.GetProperty, position = r0, force = force, $
                         viscosity = eta

  r1 = r0*[1., 1., -1]
  h = r0[2]
  (self.sources[1]).SetProperty, viscosity = eta, position = r1, $
     force = -force
  (self.sources[2]).SetProperty, viscosity = eta, position = r1, $
     force = -2.*h*force
  (self.sources[3]).SetProperty, viscosity = eta, position = r1, $
     force = 2.*h^2*force
end

;+
; blakeflow::GetProperty
;-
pro blakeflow::GetProperty, _ref_extra = re

  COMPILE_OPT IDL2, HIDDEN

  (self.sources[0]).GetProperty, _extra = re
end

;+
; blakeflow::Init()
;
; :Returns:
;    1 for success, 0 for failure
;
; :Params:
;    position
;        3-element position vector
;    force
;        3-element force vector
;    viscosity
;        viscosity of medium
;-
function blakeflow::Init, position = position, $
                          force = force, $
                          viscosity = viscosity

  COMPILE_OPT IDL2, HIDDEN

  void = self.flowfield::Init()
  
  src = flowsource(Gstokeslet(position = position, viscosity = viscosity), $
                   force = force)

  help, force

  r0 = src.position
  r1 = r0 * [1., 1., -1.]
  h = r0[2]

  self.add, flowsource(Gstokeslet(position = r1, $
                                  viscosity = viscosity), $
                       force = -force)
  
  self.add, flowsource(Gsourcedoublet(position = r1, $
                                      viscosity = viscosity), $
                       force = -2.*h*force)

  self.add, flowsource(Gstokesdoublet(position = r1, $
                                      viscosity = viscosity), $
                       force = 2.*h^2*force)
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
