My subclasses describing a configuration/settings necessary to build some third-party library used by VM
or by one of it's plugins.

We cannot use cmake configuration for those libraries, since most of them having own 
configuration/make scripts which build that library.

I serve as a convenience layer for building those libraries and connecting them with cmake configuration,
as well as provide necessary information, what output file(s) should be bundled with virtual machine.
