Some overrides to make freetype build on windows:

Two artifacts to copy:

libfreetype.dll.a
libfreetype-6.dll

the first one is used at link time with FTPlugin to 
designate the exported symbols of .dll as well as .dll file name.

The second one is ready to use library produced by freetype makefiles.

We pass

 -march=i686

instead of

 -arch i386

to freetype configure, because MSYS GCC on windows don't understands the -arch option.
