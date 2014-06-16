a base class for generating cmake files.
Mainly provides a helper methods of cmake commands api.

CMakeVMMaker in a couple of sentences.
===================================

The heart of the package is CMakeGenerator and its two subclasses CMakeVMGenerator and CMakePluginGenerator.

CMakeGenerator collects information from CPlatformConf, CMThirdpartyLibrary and InterpreterPlugins and writes it out to CMake files and associated directories. From there, the user invokes cmake and make using a generated build.sh script.

The programmer directs the flow of the generator by coding a subclass of CPlatformConf, setting it up correctly and asking it to generate itself. The configuration then invokes the CMakeVMGenerator passing itself as an argument. The VMGeneratator extracts the information and utilizes VMPluginGenerator to generate plugin stuff, the CPlatformConf to generate other stuff and CMThirdPartyLibrary's to generate other stuff. The end result is a CMake evironment that is set up to correctly build a VM

(taken from http://forum.world.st/CMakeVMMaker-in-a-nutshell-td4762751.html)