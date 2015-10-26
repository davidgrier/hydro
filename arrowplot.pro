function arrowplot, x, y, $
                    narrows = narrows, $
                    _extra = extra

  COMPILE_OPT IDL2

  narrows = isa(narrows, /number, /scalar) ? long(narrows) : 5
  
  pl = plot(x, y, _extra = extra, /undocumented)

  ;;; interval between arrows
  npts = n_elements(x)
  ds = npts / (narrows + 1)
  if ds le 0 then return, pl

  ;;; indexes of points that get arrows
  ndx = (lindgen(narrows) + 1) * ds

  ;;; clip arrows top plot window
  xrange = pl.xrange
  yrange = pl.yrange
  ax = x[ndx]
  ay = y[ndx]
  w = where((ax gt xrange[0]) * (ax lt xrange[1]) * $
            (ay gt yrange[0]) * (ay lt yrange[1]), /null)
  ndx = ndx[w]
  ndx = [transpose(ndx), transpose(ndx+1)]
  
  ;;; color arrows to match data
  vc = pl.vert_colors
  ct = pl.rgb_table
  cndx = reform(vc[ndx[0, *]])
  color = ct[*, cndx]

  ;;; plot arrowheads
  ar = arrow(x[ndx], y[ndx], /data, color = color, $
             _extra = extra, /undocumented)
  return, pl
end
