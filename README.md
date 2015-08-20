# hydro
## Stokeslet API for IDL

This repository contains IDL object that are intended to be useful for
modeling hydrodynamic flows, and motions of objects within
hydrodynamic flows.

IDL is the Interactive Data Language, and is a product of
[Exelis Visual Information Solutions](http://exelisvis.com/Home.aspx)

**`hydro`** is licensed under the
[GPLv3.](http://www.gnu.org/licenses/licenses.html#GPL)

---

### Oseen tensors
These objects calculate Oseen tensors, 3x3 tensors that describe
sources of flow.  Specifically, they describe how the flow velocity
at a specified point depends on a force applied at the position of
the source.

* `oseentensor`  
   Base class for Oseen tensors.
* `Gstokeslet`  
   Object class for a stokeslet.  
   Reference: C. Pozrikidis, *Boundary Integral and Singularity Methods
   for Linearized Viscous Flow*
   (Cambridge University Press, New York, 1992).
* `Gstokesdoublet`  
   Object class for a stokes doublet
* `Gsourcedoublet`  
   Object class for a source doublet

### Flow fields
These objects describe flow field that consist of one or more sources
of flow, each of which
consists of an Oseen tensor and a specified force.

* `flowsource`  
   Computes the flow velocity at specified positions due to a
   specified Oseen tensor and driving force.
* `flowfield`  
   Computes the flow velocity at specified positions due to a set of
   sources described by `flowsource` objects.
* `blakeflow`  
   Computes the flow velocity at specified positions due to a
   stokeslet driven by a specified force at a specified position above
   a horizontal wall in the plane z = 0.  This flow field is described
   by
   J. R. Blake, *Proc. Cambridge Phil. Soc.* **70**, 303-310 (1971).
   
### Motion in flow fields

* `faxen`
   Computes the velocity of a sphere at a specified position in a
   specified flow field.

### Documentation

* `makedocs.pro`  
   IDL batch file that creates documentation for **`hydro`** using
[IDLdoc](https://github.com/mgalloy/idldoc).
