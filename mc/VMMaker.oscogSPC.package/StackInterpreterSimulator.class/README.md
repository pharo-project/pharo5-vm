This class defines basic memory access and primitive simulation so that the StackInterpreter can run simulated in the Squeak environment.  It also defines a number of handy object viewing methods to facilitate pawing around in the object memory.

To see the thing actually run, you could (after backing up this image and changes), execute

	(StackInterpreterSimulator new openOn: Smalltalk imageName) test

	((StackInterpreterSimulator newWithOptions: #(NewspeakVM true MULTIPLEBYTECODESETS true))
		openOn: 'ns101.image') test

and be patient both to wait for things to happen, and to accept various things that may go wrong depending on how large or unusual your image may be.  We usually do this with a small and simple benchmark image.

Here's an example of what Eliot uses to launch the simulator in a window.  The bottom-right window has a menu packed with useful stuff:

| vm |
vm := StackInterpreterSimulator newWithOptions: #().
vm openOn: '/Users/eliot/Squeak/Squeak4.4/trunk44.image'.
vm setBreakSelector: #&.
vm openAsMorph; run