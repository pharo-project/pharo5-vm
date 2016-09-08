This class defines basic memory access and primitive simulation so that the Interpreter can run simulated in the Squeak environment.  It also defines a number of handy object viewing methods to facilitate pawing around in the object memory.

To see the thing actually run, you could (after backing up this image and changes), execute

	(InterpreterSimulator new openOn: Smalltalk imageName) test

and be patient both to wait for things to happen, and to accept various things that may go wrong depending on how large or unusual your image may be.  We usually do this with a small and simple benchmark image. You will probably have more luck using InterpreteSimulatorLSB or InterpreterSimulatorMSB as befits your machine.