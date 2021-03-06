OpenGL Bindings for APL

# Introduction

The OpenGL Bindings for APL provide a way to call OpenGL functions directly from Dyalog APL for Windows. They are distributed as a collection of namespace scripts, which can be loaded using the SALT features built into Dyalog APL.

# Getting started

1. Install Dyalog APL for Windows.

1. Obtain the scripts and put them in a folder on your computer (or accessible from your computer).

1. Add that folder to the SALT path of your Dyalog APL interpreter. To do this from the Dyalog APL development environment, go to Options -> Configure... -> SALT

1. In the session, type:
```apl
      ]load DOFDemo
      DOFDemo.main
```
This will launch the Depth of Field demo. You should see a new window appear containing five different coloured 3D teapots. Close the window to end the demo.

# The libraries

## OpenGL

## GLUT

## Other libraries

# Conventions

## Functions returning a fixed length array

## Functions returning a variable length array

(e.g. a b c←glGenTextures 3 3 ⍝ looks a bit odd!)

# Demos

## DOFDemo

## EMDemo

Note that this demo uses Cube Map Texture Selection, a feature that was first introduced as an extension (http://www.opengl.org/registry/specs/ARB/texture_cube_map.txt) to OpenGL 1.2(?), and then incorporated into the core of OpenGL 1.3.

# References

* OpenGL: http://www.opengl.org/
* GLUT: http://www.opengl.org/resources/libraries/glut/
* GLU: http://www.opengl.org/resources/libraries/glx/
* WGL: http://msdn.microsoft.com/en-us/library/dd374394.aspx
* GDI: http://msdn.microsoft.com/en-us/library/ms533798.aspx
* User32: http://en.wikipedia.org/wiki/Windows_USER
