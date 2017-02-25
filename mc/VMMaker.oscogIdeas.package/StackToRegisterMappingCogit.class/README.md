StackToRegisterMappingCogit is an optimizing code generator that eliminates a lot of stack operations and inlines some special selector arithmetic.  It does so by a simple stack-to-register mapping scheme based on deferring the generation of code to produce operands until operand-consuming operations.  The operations that consume operands are sends, stores and returns.

See methods in the class-side documentation protocol for more detail.

Instance Variables
	callerSavedRegMask:							<Integer>
	ceEnter0ArgsPIC:								<Integer>
	ceEnter1ArgsPIC:								<Integer>
	ceEnter2ArgsPIC:								<Integer>
	ceEnterCogCodePopReceiverArg0Regs:		<Integer>
	ceEnterCogCodePopReceiverArg1Arg0Regs:	<Integer>
	debugBytecodePointers:						<Set of Integer>
	debugFixupBreaks:								<Set of Integer>
	debugStackPointers:							<CArrayAccessor of (Integer|nil)>
	methodAbortTrampolines:						<CArrayAccessor of Integer>
	methodOrBlockNumTemps:						<Integer>
	optStatus:										<Integer>
	picAbortTrampolines:							<CArrayAccessor of Integer>
	picMissTrampolines:							<CArrayAccessor of Integer>
	realCEEnterCogCodePopReceiverArg0Regs:		<Integer>
	realCEEnterCogCodePopReceiverArg1Arg0Regs:	<Integer>
	regArgsHaveBeenPushed:						<Boolean>
	simSelf:											<CogSimStackEntry>
	simSpillBase:									<Integer>
	simStack:										<CArrayAccessor of CogSimStackEntry>
	simStackPtr:									<Integer>
	traceSimStack:									<Integer>
	useTwoPaths									<Boolean>

callerSavedRegMask
	- the bitmask of the ABI's caller-saved registers

ceEnter0ArgsPIC ceEnter1ArgsPIC ceEnter2ArgsPIC
	- the trampoline for entering an N-arg PIC

ceEnterCogCodePopReceiverArg0Regs ceEnterCogCodePopReceiverArg1Arg0Regs
	- the trampoline for entering a method with N register args
	
debugBytecodePointers
	- a Set of bytecode pcs for setting breakpoints (simulation only)

debugFixupBreaks
	- a Set of fixup indices for setting breakpoints (simulation only)

debugStackPointers
	- an Array of stack depths for each bytecode for code verification

methodAbortTrampolines
	- a CArrayAccessor of abort trampolines for 0, 1, 2 and N args

methodOrBlockNumTemps
	- the number of method or block temps (including args) in the current compilation unit (method or block)

optStatus
	- the variable used to track the status of ReceiverResultReg for avoiding reloading that register with self between adjacent inst var accesses

picAbortTrampolines
	- a CArrayAccessor of abort trampolines for 0, 1, 2 and N args

picMissTrampolines
	- a CArrayAccessor of abort trampolines for 0, 1, 2 and N args

realCEEnterCogCodePopReceiverArg0Regs realCEEnterCogCodePopReceiverArg1Arg0Regs
	- the real trampolines for ebtering machine code with N reg args when in the Debug regime

regArgsHaveBeenPushed
	- whether the register args have been pushed before frame build (e.g. when an interpreter primitive is called)

simSelf
	- the simulation stack entry representing self in the current compilation unit

simSpillBase
	- the variable tracking how much of the simulation stack has been spilled to the real stack

simStack
	- the simulation stack itself

simStackPtr
	- the pointer to the top of the simulation stack

useTwoPaths
	- a variable controlling whether to create two paths through a method based on the existence of inst var stores.  With immutability this causes a frameless path to be generated if an otherwise frameless method is frameful simply because of inst var stores.  In this case the test to take the first frameless path is if the receiver is not immutable.  Without immutability, if a frameless method contains two or more inst var stores, the first path will be code with no store check, chosen by a single check for the receiver being in new space.
