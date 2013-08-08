I am generating a cmake configuration file (CMakeLists.txt)
for building a Squeak Virtual Machine.

Usage: 

CMakeVMGenerator new generate: CogMacOSConfig

or

CMakeVMGenerator new generate: (CogMacOSConfig new setOption: ... ; yourself)

you can provide any valid configuration instead of CogMacOSConfig for build. 

Generator creating a '../build' directory (relative to current one)
and placing config files there.
Also, it expects that appropriate VM (re)sources can be found simplarily:
  ../platforms
  ../src
 but these settings are just default ones and could be changed in config
 (see senders of #topDir #buildDir and #srcDir )

Generator and cmake configs are designed so, that any file-system operations are performed in
<build> directory.
So, if you want to build multiple VMs , using same generated sources, but different configs, you can simply
use different build directories.

