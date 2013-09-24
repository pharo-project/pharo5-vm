This class defines basic memory access and primitive simulation so that the CoInterpreter can run simulated in the Squeak environment.  It also defines a number of handy object viewing methods to facilitate pawing around in the object memory.  Remember that you can test the Cogit using its class-side in-image compilation facilities.

To see the thing actually run, you could (after backing up this image and changes), execute

	(CogVMSimulator new openOn: Smalltalk imageName) test

and be patient both to wait for things to happen, and to accept various things that may go wrong depending on how large or unusual your image may be.  We usually do this with a small and simple benchmark image.

Here's an example to launch the simulator in a window.  The bottom-right window has a menu packed with useful stuff:

(CogVMSimulator newWithOptions: #(Cogit StackToRegisterMappingCogit))
	desiredNumStackPages: 8;
	openOn: '/Users/eliot/Cog/startreader.image';
	openAsMorph;
	run

Here's a hairier example that I (Eliot) actually use in daily development with some of the breakpoint facilities commented out.

| cos proc opts |
CoInterpreter initializeWithOptions: (opts := Dictionary newFromPairs: #(Cogit StackToRegisterMappingCogit)).
CogVMSimulator chooseAndInitCogitClassWithOpts: opts.
cos := CogVMSimulator new.
"cos initializeThreadSupport." "to test the multi-threaded VM"
cos desiredNumStackPages: 8. "to set the size of the stack zone"
"cos desiredCogCodeSize: 8 * 1024 * 1024." "to set the size of the Cogit's code zone"
cos openOn: '/Users/eliot/Squeak/Squeak4.4/trunk44.image'. "choose your favourite image"
"cos setBreakSelector: 'r:degrees:'." "set a breakpoint at a specific selector"
proc := cos cogit processor.
"cos cogit sendTrace: 7." "turn on tracing"
"set a complex breakpoint at a specific point in machine code"
"cos cogit singleStep: true; breakPC: 16r56af; breakBlock: [:cg|  cos framePointer > 16r101F3C and: [(cos longAt: cos framePointer - 4) = 16r2479A and: [(cos longAt: 16r101F30) = (cos longAt: 16r101F3C) or: [(cos longAt: 16r101F2C) = (cos longAt: 16r101F3C)]]]]; sendTrace: 1".
"[cos cogit compilationTrace: -1] on: MessageNotUnderstood do: [:ex|]." "turn on compilation tracing in the StackToRegisterMappingCogit"
"cos cogit setBreakMethod: 16rB38880."
cos
	openAsMorph;
	"toggleTranscript;" "toggleTranscript will send output to the Transcript instead of the morph's rather small window"
	halt;
	run