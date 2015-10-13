; docformat = 'rst'

;+
; Mean velocity $\vec{v}(\vec{r})$
; at specified points $\vec{r}$ associated
; with an ensemble of measured trajectories.
;
; :Author:
;    David G. Grier, New York University
;
; :Copyright:
;    Copyright (c) 2015 David G. Grier
;-

;+
; Calculate the velocity $\vec{v}(\vec{r}),
; or optionally the flux $\vec{j}(\vec{r}),
; at positions $\vec{r}$ as an average over the
; recorded trajectories.
;
; :Params:
;    r : in, required, type=`fltarr(2,N)`
;        Array of N sets of Cartesian coordinates, $\vec{r}$.
;
; :Keywords:
;    flux : in, optional, type=keywords
;        If set, return the flux $\vec{j}(\vec{r})$ rather than
;        the velocity $\vec{v}(\vec{r})$.
;
; :Returns:
;    2xN element array of velocity vectors, $\vec{v}(\vec{r})$.
;-
function meanvelocity::Compute, r, flux = flux

  COMPILE_OPT IDL2, HIDDEN

  self.update
  v = *(self.v)
  flux_x = transpose(kde(*(self.r), r, weight = v[0, *]))
  flux_y = transpose(kde(*(self.r), r, weight = v[1, *]))
  if ~keyword_set(flux) then begin
     rho = kde(*(self.r), r)
     flux_x /= rho
     flux_y /= rho
  endif
  
  return, [flux_x, flux_y]
end

;+
; Update internal array of positions and velocities
; from the list of trajectories.
;
; :Hidden:
;-
pro meanvelocity::Update, fraction = fraction

  COMPILE_OPT IDL2, HIDDEN

  if ~self.needsupdate && ~isa(fraction, /number) then $
     return

  fraction = isa(fraction, /number, /scalar) ? float(fraction) > 0. : 1.
  seed = systime(1)
  
  r = []
  v = []
  foreach t, self.trajectories do begin
     if randomu(seed) gt fraction then continue
     r = [[r], [(t[*, 1:*] + t)/2.]]
     v = [[v], [(t[*, 1:*] - t)]]
  endforeach
  self.r = ptr_new(r, /no_copy)
  self.v = ptr_new(v, /no_copy)
  
  self.needsupdate = 0
end

;+
; Add a trajectory to the list.
;
; :Params:
;    trajectory : in, required, type=`fltarr(2,N)`
;-
pro meanvelocity::Add, trajectory

  COMPILE_OPT IDL2, HIDDEN

  if n_params() ne 1 then begin
     message, 'Usage: ADD(trajectory)', /inf
     return
  endif

  if ~isa(trajectory, /number, /array) then begin
     message, 'TRAJECTORY must be a numerical array', /inf
     return
  endif

  sz = size(trajectory)
  if sz[0] ne 2 then begin
     message, $
        'TRAJECTORY should consist of two or more Cartesian coordinates', $
        /inf
     return
  endif
  
  case sz[1] of
     2: self.trajectories.add, trajectory
     4: begin
        h = histogram(trajectory[3, *], reverse_indices = r)
        for n = 0, n_elements(h)-1 do $
           if r[n+1] gt (r[n]+1) then $
              self.trajectories.add, trajectory[0:1, r[r[n]:r[n+1]-1]]
     end
     else: begin
        message, 'TRAJECTORY should consist of 2-dimensional coordinates', /inf
        return
     end
  endcase
  

  self.needsupdate = 1.
end

;+
; meanvelocity::GetProperty
;-
pro meanvelocity::GetProperty, r = r, $
                               v = v, $
                               trajectories = trajectories, $
                               count = count, $
                               xrange = xrange, $
                               yrange = yrange

  COMPILE_OPT IDL2, HIDDEN

  if arg_present(r) then $
     r = (ptr_valid(self.r)) ? *(self.r) : []

  if arg_present(v) then $
     v = (ptr_valid(self.v)) ? *(self.v) : []

  if arg_present(trajectories) then $
     trajectories = self.trajectories

  if arg_present(count) then $
     count = self.trajectories.count()

  if arg_present(xrange) || arg_present(yrange) then begin
     self.update
     if ~ptr_valid(self.r) then begin
        xrange = fltarr(2)
        yrange = fltarr(2)
     endif else begin
        xrange = [min((*(self.r))[0, *]), max((*(self.r))[0, *])]
        yrange = [min((*(self.r))[1, *]), max((*(self.r))[1, *])]
     endelse
  endif
end
  
;+
; meanvelocity::Init()
;
; :Returns:
;    1 for success, 0 for failure
;-
function meanvelocity::Init

  COMPILE_OPT IDL2, HIDDEN

  self.trajectories = list()
  return, 1B
end

;+
; meanvelocity__define
;
; :Fields:
;    trajectories
;        list of trajectory data
;    r
;        pointer to positions
;    v
;        pointer to computed velocities
;
; :Hidden:
;-
pro meanvelocity__define

  COMPILE_OPT IDL2, HIDDEN

  struct = {meanvelocity, $
            inherits IDL_Object, $
            trajectories: obj_new(), $
            r: ptr_new(), $
            v: ptr_new(), $
            needsupdate: 0 $
           }
end
