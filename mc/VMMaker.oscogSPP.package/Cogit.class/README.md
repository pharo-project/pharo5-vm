I am the code generator for the Cog VM.  My job is to produce machine code versions of methods for faster execution and to manage inline caches for faster send performance.  I can be tested in the current image using my class-side in-image compilation facilities.  e.g. try

	StackToRegisterMappingCogit genAndDis: (Integer >> #benchFib)

I have concrete subclasses that implement different levels of optimization:
	SimpleStackBasedCogit is the simplest code generator.

	StackToRegisterMappingCogit is the current production code generator  It defers pushing operands
	to the stack until necessary and implements a register-based calling convention for low-arity sends.

	StackToRegisterMappingCogit is an experimental code generator with support for counting
	conditional branches, intended to support adaptive optimization.

coInterpreter <CoInterpreterSimulator>
	the VM's interpreter with which I cooperate
methodZoneManager <CogMethodZoneManager>
	the manager of the machine code zone
objectRepresentation <CogObjectRepresentation>
	the object used to generate object accesses
processor <BochsIA32Alien|?>
	the simulator that executes the IA32/x86 machine code I generate when simulating execution in Smalltalk
simulatedTrampolines <Dictionary of Integer -> MessageSend>
	the dictionary mapping trap jump addresses to run-time routines used to warp from simulated machine code in to the Smalltalk run-time.
simulatedVariableGetters <Dictionary of Integer -> MessageSend>
	the dictionary mapping trap read addresses to variables in run-time objects used to allow simulated machine code to read variables in the Smalltalk run-time.
simulatedVariableSetters <Dictionary of Integer -> MessageSend>
	the dictionary mapping trap write addresses to variables in run-time objects used to allow simulated machine code to write variables in the Smalltalk run-time.
printRegisters printInstructions clickConfirm <Boolean>
	flags controlling debug printing and code simulation
breakPC <Integer>
	machine code pc breakpoint
cFramePointer cStackPointer <Integer>
	the variables representing the C stack & frame pointers, which must change on FFI callback and return
selectorOop <sqInt>
	the oop of the methodObj being compiled
methodObj <sqInt>
	the bytecode method being compiled
initialPC endPC <Integer>
	the start and end pcs of the methodObj being compiled
methodOrBlockNumArgs <Integer>
	argument count of current method or block being compiled
needsFrame <Boolean>
	whether methodObj or block needs a frame to execute
primitiveIndex <Integer>
	primitive index of current method being compiled
methodLabel <CogAbstractOpcode>
	label for the method header
blockEntryLabel <CogAbstractOpcode>
	label for the start of the block dispatch code
stackOverflowCall <CogAbstractOpcode>
	label for the call of ceStackOverflow in the method prolog
sendMissCall <CogAbstractOpcode>
	label for the call of ceSICMiss in the method prolog
entryOffset <Integer>
	offset of method entry code from start (header) of method
entry <CogAbstractOpcode>
	label for the first instruction of the method entry code
noCheckEntryOffset <Integer>
	offset of the start of a method proper (after the method entry code) from start (header) of method
noCheckEntry <CogAbstractOpcode>
	label for the first instruction of start of a method proper
fixups <Array of <AbstractOpcode Label | nil>>
	the labels for forward jumps that will be fixed up when reaching the relevant bytecode.  fixup shas one element per byte in methodObj's bytecode
abstractOpcodes <Array of <AbstractOpcode>>
	the code generated when compiling methodObj
byte0 byte1 byte2 byte3 <Integer>
	individual bytes of current bytecode being compiled in methodObj
bytecodePointer <Integer>
	bytecode pc (same as Smalltalk) of the current bytecode being compiled
opcodeIndex <Integer>
	the index of the next free entry in abstractOpcodes (this code is translated into C where OrderedCollection et al do not exist)
numAbstractOpcodes <Integer>
	the number of elements in abstractOpcocdes
blockStarts <Array of <BlockStart>>
	the starts of blocks in the current method
blockCount
	the index into blockStarts as they are being noted, and hence eventually the total number of blocks in the current method
labelCounter <Integer>
	a nicety for numbering labels not needed in the production system but probably not expensive enough to worry about
ceStackOverflowTrampoline <Integer>
ceSend0ArgsTrampoline <Integer>
ceSend1ArgsTrampoline <Integer>
ceSend2ArgsTrampoline <Integer>
ceSendNArgsTrampoline <Integer>
ceSendSuper0ArgsTrampoline <Integer>
ceSendSuper1ArgsTrampoline <Integer>
ceSendSuper2ArgsTrampoline <Integer>
ceSendSuperNArgsTrampoline <Integer>
ceSICMissTrampoline <Integer>
ceCPICMissTrampoline <Integer>
ceStoreCheckTrampoline <Integer>
ceReturnToInterpreterTrampoline <Integer>
ceBaseFrameReturnTrampoline <Integer>
ceSendMustBeBooleanTrampoline <Integer>
ceClosureCopyTrampoline <Integer>
	the various trampolines (system-call-like jumps from machine code to the run-time).
	See Cogit>>generateTrampolines for the mapping from trampoline to run-time
	routine and then read the run-time routine for a funcitonal description.
ceEnterCogCodePopReceiverReg <Integer>
	the enilopmart (jump from run-time to machine-code)
methodZoneBase <Integer>
