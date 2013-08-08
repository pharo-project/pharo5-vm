This is an abstract class and it is the root configuration for building all types of Cog VMs on MS-Windows platform.


What you need to get started:

Download and install Msys, with C/C++ compiler support:
	http://www.mingw.org/wiki/msys
	
Download and install Git:
	http://code.google.com/p/msysgit/
	

///
Optional: add git to the PATH variable:

Add path to git for msys:
Control panel -> System -> System Properies / Advanced  [ Environment Variables ]

There should be already:
C:\Program Files\Git\cmd

add:

C:\Program Files\Git\bin

/// For automated builds, add SQUEAKVM environment variable and set it to the full path to squeak executable.

(Control panel -> System -> System Properies / Advanced  [ Environment Variables ])

in windows shell you can use it then to run squeak: %SQUEAKVM%  , and in mingw bash shell, use $SQUEAKVM

/// Install CMake:
http://www.cmake.org/cmake/resources/software.html

(during installation, in install options , make sure that you choose to add CMake to PATH)


Note, to run cmake under msys shell, you have to explicitly specify the msys makefiles generator, because default one is MS:

cmake . -G"MSYS Makefiles"


Fore more information, check the class comments of all the superclasses.
