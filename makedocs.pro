;+
; :Description:
;    Generate documentation for the hydro package.
;
; :Uses:
;    IDLdoc by Michael Galloy
;
; :Author:
;    David G. Grier, New York University
;
; :Copyright:
;    Copyright (c) 2015 David G. Grier
;-
if file_which('idldoc.*') then begin $
   idldoc, root='.', output='docs', $
           title='API documentation for hydro', $
           subtitle='Stokeslets for IDL', $
           /use_latex, /nosource, $
           format_style='rst', markup_style='rst' & $
endif else $
   message, "Creating documentation requires Michael Galloy's IDLdoc package"

exit
