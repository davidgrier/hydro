function flowline, flow, r0, $
                   step_size = step_size, $
                   bounding_box = bounding_box, $
                   max_steps = max_steps, $
                   lower_limit = lower_limit

  COMPILE_OPT IDL2

  oexcept = !except
  !except = 0
  
  step_size = isa(step_size, /number, /scalar) ? float(step_size) : 0.01
  bounding_box = isa(bounding_box, /number, /array) ? $
                 float(bounding_box) : $
                 2.*[[-1, -1, 0], [1, 1, 1]]
  max_steps = isa(max_steps, /number, /scalar) ? long(max_steps) : 1000L
  lower_limit = isa(lower_limit, /number, /scalar) ? float(lower_limit) : 0.

  r = r0
  v = flow.compute(r0)
  trajectory = [r, v]

  for nsteps = 1L, max_steps do begin
     ;; out of bounds
     if ((total(r lt bounding_box[*, 0]) + $
          total(r gt bounding_box[*, 1])) gt 0) then break

     if (r[2] le lower_limit) && (dr[2] le 0.) then begin
        r[2] = lower_limit
        dr[2] = 0.
     endif
     
     if ((mv = sqrt(total(v^2))) le 0.1* step_size) then begin
        print, 'not moving', mv
        break
     endif
     
     dr = v * step_size/mv
     r += dr
     v = flow.compute(r)
     trajectory = [[trajectory], [[r, v]]]
  endfor

  !except = oexcept
  return, trajectory
end

     
