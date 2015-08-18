/* Index used for searching */
/*
   Fields used:
     url, name, type, filename, authors, routine name, comments, parameters,
     categories, and attributes
*/
title = "API documentation for hydro";
subtitle = "Stokeslets for IDL";
libdata = new Array();
libdataItem = 0;



libdata[libdataItem++] = new Array("./blakeflow__define.html", "blakeflow__define.pro", '.pro file in <a href="./dir-overview.html">./ directory</a>', "blakeflow__define.pro", "    David G. Grier, New York University   ", "", " Flow field at specified points due to a stokeslet near  a horizontal wall in the plane $z = 0$.   Reference:  J. R. Blake,  A note on the image system for a stokeslet in  a no-slip boundary,  Proc. Cambridge Phil. Soc. 70, 303-310 (1971).   ", "", "          -1", "    Copyright (c) 2015 David G. Grier  ");
  
  
  libdata[libdataItem++] = new Array("./blakeflow__define.html#blakeflow::SetProperty", "blakeflow::SetProperty", 'routine in <a href="./blakeflow__define.html">blakeflow__define.pro</a>', "blakeflow__define.pro", "", "blakeflow::SetProperty", " blakeflow::SetProperty  ", "_extra", "          -1", "");
  
  libdata[libdataItem++] = new Array("./blakeflow__define.html#blakeflow::GetProperty", "blakeflow::GetProperty", 'routine in <a href="./blakeflow__define.html">blakeflow__define.pro</a>', "blakeflow__define.pro", "", "blakeflow::GetProperty", " blakeflow::GetProperty  ", "_ref_extra", "          -1", "");
  
  libdata[libdataItem++] = new Array("./blakeflow__define.html#blakeflow::Init", "blakeflow::Init", 'routine in <a href="./blakeflow__define.html">blakeflow__define.pro</a>', "blakeflow__define.pro", "", "blakeflow::Init", " blakeflow::Init()   ", "positionforceviscosity", "          -1", "    1 for success, 0 for failure   ");
  
  

libdata[libdataItem++] = new Array("./faxen__define.html", "faxen__define.pro", '.pro file in <a href="./dir-overview.html">./ directory</a>', "faxen__define.pro", "    David G. Grier, New York University   ", "", " Calculate the velocity, $\vec{v}(\vec{r})$,  of a sphere of radius $a$  at position(s) $\vec{r}$ within a hydrodynamic flow,  $\vec{u}(\vec{r})$.   The velocity is computed according to  Faxen's first law:  $$\vec{v}(\vec{r}) = \vec{u}(\vec{r}) +                       \frac{a^2}{6} \, \nabla^2 \vec{u}$$   ", "", "          -1", "    Copyright (c) 2015 David G. Grier  ");
  
  
  libdata[libdataItem++] = new Array("./faxen__define.html#faxen::Compute", "faxen::Compute", 'routine in <a href="./faxen__define.html">faxen__define.pro</a>', "faxen__define.pro", "", "faxen::Compute", " Calculate the velocity of the sphere at a specified  set of points within the flow according to  Faxen's first law:  $$\vec{v}(\vec{r}) = \vec{u}(\vec{r}) +                       \frac{a^2}{6} \, \nabla^2 \vec{u}$$   ", "r        Array of N Cartesian coordinates.  ", "          -1", "");
  
  libdata[libdataItem++] = new Array("./faxen__define.html#faxen::SetProperty", "faxen::SetProperty", 'routine in <a href="./faxen__define.html">faxen__define.pro</a>', "faxen__define.pro", "", "faxen::SetProperty", " faxen::SetProperty  ", "radius        Radius $a$ of the sphere in meters.  flow        Object reference to a flowfield object         defining the hydrodynamic flow, $\vec{u}(\vec{r})$.   ", "          -1", "");
  
  libdata[libdataItem++] = new Array("./faxen__define.html#faxen::GetProperty", "faxen::GetProperty", 'routine in <a href="./faxen__define.html">faxen__define.pro</a>', "faxen__define.pro", "", "faxen::GetProperty", " faxen::GetProperty  ", "radius        Radius $a$ of the sphere in meters.  flow        Object reference to a flowfield object         defining the hydrodynamic flow, $\vec{u}(\vec{r})$.   ", "          -1", "");
  
  libdata[libdataItem++] = new Array("./faxen__define.html#faxen::Init", "faxen::Init", 'routine in <a href="./faxen__define.html">faxen__define.pro</a>', "faxen__define.pro", "", "faxen::Init", " faxen::Init()   ", "radius        Radius $a$ of the sphere in meters.  flow        Object reference to a flowfield or flowsource         responsible for the hydrodynamic flow $\vec{u}(\vec{r})$         around the sphere.  ", "          -1", "    1 for success, 0 for failure   ");
  
  

libdata[libdataItem++] = new Array("./flowfield__define.html", "flowfield__define.pro", '.pro file in <a href="./dir-overview.html">./ directory</a>', "flowfield__define.pro", "    David G. Grier, New York University   ", "", " Flow field $\vec{u}(\vec{r})$  at specified points $\vec{r}$ due to a set of flow sources.   ", "", "          -1", "    Copyright (c) 2015 David G. Grier  ");
  
  
  libdata[libdataItem++] = new Array("./flowfield__define.html#flowfield::Compute", "flowfield::Compute", 'routine in <a href="./flowfield__define.html">flowfield__define.pro</a>', "flowfield__define.pro", "", "flowfield::Compute", " Calculate the flow velocity $\vec{u}(\vec{r})$  at positions $\vec{r}$ due to the  specified set of sources.   ", "r        Array of N sets of Cartesian coordinates, $\vec{r}$.   ", "          -1", "    3xN element array of velocity vectors, $\vec{u}(\vec{r})$.  ");
  
  libdata[libdataItem++] = new Array("./flowfield__define.html#flowfield::Add", "flowfield::Add", 'routine in <a href="./flowfield__define.html">flowfield__define.pro</a>', "flowfield__define.pro", "", "flowfield::Add", " Add a flowsource object to the list of sources.   ", "source", "          -1", "");
  
  libdata[libdataItem++] = new Array("./flowfield__define.html#flowfield::Init", "flowfield::Init", 'routine in <a href="./flowfield__define.html">flowfield__define.pro</a>', "flowfield__define.pro", "", "flowfield::Init", " flowfield::Init()   ", "", "          -1", "    1 for success, 0 for failure  ");
  
  

libdata[libdataItem++] = new Array("./flowsource__define.html", "flowsource__define.pro", '.pro file in <a href="./dir-overview.html">./ directory</a>', "flowsource__define.pro", "    David G. Grier, New York University   ", "", " Flow field $\vec{u}(\vec{r})$  at specified points $\vec{r}$  due to a localized source  of flow consisting of an Oseen tensor $\mathsf{G}(\vec{r})$  and a driving force $\vec{f}_0$.  $$\vec{u}(\vec{r}) =     \mathsf{G}(\vec{r} - \vec{r}_0) \cdot \vec{f}_0  $$   ", "", "          -1", "    Copyright (c) 2015 David G. Grier  ");
  
  
  libdata[libdataItem++] = new Array("./flowsource__define.html#flowsource::Compute", "flowsource::Compute", 'routine in <a href="./flowsource__define.html">flowsource__define.pro</a>', "flowsource__define.pro", "", "flowsource::Compute", " Calculate the flow velocity at r due to the specified source.   ", "r        Array of N Cartesian coordinates.   ", "          -1", "    3xN array of velocity vectors at each coordinate.  ");
  
  libdata[libdataItem++] = new Array("./flowsource__define.html#flowsource::SetProperty", "flowsource::SetProperty", 'routine in <a href="./flowsource__define.html">flowsource__define.pro</a>', "flowsource__define.pro", "", "flowsource::SetProperty", " flowsource::SetProperty  ", "force        3-element vector describing the force $\vec{f}_0$         responsible for the flow.   _extra", "          -1", "");
  
  libdata[libdataItem++] = new Array("./flowsource__define.html#flowsource::GetProperty", "flowsource::GetProperty", 'routine in <a href="./flowsource__define.html">flowsource__define.pro</a>', "flowsource__define.pro", "", "flowsource::GetProperty", " flowsource::GetProperty  ", "force        3-element vector describing the force $\vec{f}_0$         responsible for the flow.   _ref_extra", "          -1", "");
  
  libdata[libdataItem++] = new Array("./flowsource__define.html#flowsource::Init", "flowsource::Init", 'routine in <a href="./flowsource__define.html">flowsource__define.pro</a>', "flowsource__define.pro", "", "flowsource::Init", " flowsource::Init(oseentensor)   ", "force        Force vector in units of newtons  _ref_extraoseentensor        Reference to oseentensor object describing flow.   ", "          -1", "    1 for success, 0 for failure   ");
  
  

libdata[libdataItem++] = new Array("./Gsourcedoublet__define.html", "Gsourcedoublet__define.pro", '.pro file in <a href="./dir-overview.html">./ directory</a>', "Gsourcedoublet__define.pro", "    David G. Grier, New York University   ", "", " Oseen tensor for a source doublet oriented relative to the  plane $z = 0$.  $$\mathsf{G}_{\alpha \beta}(\vec{r})     =     (1 - 2 \delta_{\beta z}) \,     \frac{\partial}{\partial r_\beta} \,     \mathsf{G}^\text{stokeslet}_{\alpha \beta}(\vec{r})  $$   ", "", "          -1", "    Copyright (c) 2015 David G. Grier  ");
  
  
  libdata[libdataItem++] = new Array("./Gsourcedoublet__define.html#Gsourcedoublet::Compute", "Gsourcedoublet::Compute", 'routine in <a href="./Gsourcedoublet__define.html">Gsourcedoublet__define.pro</a>', "Gsourcedoublet__define.pro", "", "Gsourcedoublet::Compute", " Compute the Oseen tensor for a source doublet at a specified  position.   ", "r        Position in Cartesian coordinates.  ", "          -1", "");
  
  

libdata[libdataItem++] = new Array("./Gstokesdoublet__define.html", "Gstokesdoublet__define.pro", '.pro file in <a href="./dir-overview.html">./ directory</a>', "Gstokesdoublet__define.pro", "    David G. Grier, New York University   ", "", " Oseen tensor for a stokes doublet oriented relative to the  plane $z = 0$.  $$\mathsf{G}_{\alpha \beta}(\vec{r})     =     \frac{1 - 2 \delta_{\beta z}}{8 \pi \eta} \,     \frac{\partial}{\partial r_\beta} \left(         \frac{r_\alpha}{r^3}     \right)  $$   ", "", "          -1", "    Copyright (c) 2015 David G. Grier  ");
  
  
  libdata[libdataItem++] = new Array("./Gstokesdoublet__define.html#Gstokesdoublet::Compute", "Gstokesdoublet::Compute", 'routine in <a href="./Gstokesdoublet__define.html">Gstokesdoublet__define.pro</a>', "Gstokesdoublet__define.pro", "", "Gstokesdoublet::Compute", " Compute the Oseen tensor for a stokes doublet at a specified  position.   ", "r        Position in Cartesian coordinates.  ", "          -1", "");
  
  

libdata[libdataItem++] = new Array("./Gstokeslet__define.html", "Gstokeslet__define.pro", '.pro file in <a href="./dir-overview.html">./ directory</a>', "Gstokeslet__define.pro", "    David G. Grier, New York University   ", "", " Oseen tensor for a stokelet.  $$\mathsf{G}_{\alpha\beta}(\vec{r})  =  \frac{1}{8 \pi \eta} \,  \left(     \frac{\delta_{\alpha\beta}}{r}     +     \frac{r_\alpha r_\beta}{r^3}  \right)$$   ", "", "          -1", "    Copyright (c) 2015 David G. Grier  ");
  
  
  libdata[libdataItem++] = new Array("./Gstokeslet__define.html#Gstokeslet::Compute", "Gstokeslet::Compute", 'routine in <a href="./Gstokeslet__define.html">Gstokeslet__define.pro</a>', "Gstokeslet__define.pro", "", "Gstokeslet::Compute", " Compute the Oseen tensor for a stokeslet at a specified position   ", "r        Position in Cartesian coordinates.  ", "          -1", "");
  
  

libdata[libdataItem++] = new Array("./makedoc.html", "makedoc.pro", '.pro file in <a href="./dir-overview.html">./ directory</a>', "makedoc.pro", "", "", "", "", "          -1", "");
  

libdata[libdataItem++] = new Array("./oseentensor__define.html", "oseentensor__define.pro", '.pro file in <a href="./dir-overview.html">./ directory</a>', "oseentensor__define.pro", "    David G. Grier, New York University.   ", "", " Oseen tensor base class for describing hydrodynamic flows  relative to specified positions.   ", "", "          -1", "    Copyright (c) 2015 David G. Grier  ");
  
  
  libdata[libdataItem++] = new Array("./oseentensor__define.html#oseentensor::CheckVector", "oseentensor::CheckVector", 'routine in <a href="./oseentensor__define.html">oseentensor__define.pro</a>', "oseentensor__define.pro", "", "oseentensor::CheckVector", " Check a provided vector to ensure that it has  a compatible type are correct number of elements.   ", "r        Position in Cartesian cooardinates   ", "          -1", "");
  
  libdata[libdataItem++] = new Array("./oseentensor__define.html#oseentensor::Compute", "oseentensor::Compute", 'routine in <a href="./oseentensor__define.html">oseentensor__define.pro</a>', "oseentensor__define.pro", "", "oseentensor::Compute", " Calculate the Oseen tensor at a specified position.   ", "r        Position in Cartesian coordinates.   ", "          -1", "    3x3 real-valued Oseen tensor  ");
  
  libdata[libdataItem++] = new Array("./oseentensor__define.html#oseentensor::Compute", "oseentensor::Compute", 'routine in <a href="./oseentensor__define.html">oseentensor__define.pro</a>', "oseentensor__define.pro", "", "oseentensor::Compute", " Calculate the Oseen tensor at a specified position.   ", "r        Position in Cartesian coordinates.  ", "          -1", "");
  
  libdata[libdataItem++] = new Array("./oseentensor__define.html#oseentensor::SetProperty", "oseentensor::SetProperty", 'routine in <a href="./oseentensor__define.html">oseentensor__define.pro</a>', "oseentensor__define.pro", "", "oseentensor::SetProperty", " oseentensor::SetProperty  ", "position        three-element array of Cartesian coordinates         specifying position of the source.  viscosity        viscosity of fluid in SI units.  ", "          -1", "");
  
  libdata[libdataItem++] = new Array("./oseentensor__define.html#oseentensor::GetProperty", "oseentensor::GetProperty", 'routine in <a href="./oseentensor__define.html">oseentensor__define.pro</a>', "oseentensor__define.pro", "", "oseentensor::GetProperty", " oseentensor::GetProperty  ", "tensor        3x3 array specifying the elements of the Oseen tensor.   position        three-element array of Cartesian coordinates         specifying position of the source.  viscosity        viscosity of fluid in SI units.  ", "          -1", "");
  
  libdata[libdataItem++] = new Array("./oseentensor__define.html#oseentensor::Init", "oseentensor::Init", 'routine in <a href="./oseentensor__define.html">oseentensor__define.pro</a>', "oseentensor__define.pro", "", "oseentensor::Init", " oseentensor::Init()   ", "position        Position of source in Cartesian coordinates.  viscosity        Viscosity of medium.  ", "          -1", "    1 for success, 0 for failure   ");
  
  

