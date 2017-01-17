This class overrides a few methods in StackInterpreterSimulator required for simulation to work on little-endian architectures (such as the x86 family of processors).  To start it up simply use StackInterpreterSimulatorLSB instead of StackInterpreterSimulator (see the class comment there for more details).  For example:

	(StackInterpreterSimulatorLSB new openOn: Smalltalk imageName) test

Note that the image must have been saved at least once on the local architecture, since the compiled VM performs some byte swapping that the simulator cannot cope with.