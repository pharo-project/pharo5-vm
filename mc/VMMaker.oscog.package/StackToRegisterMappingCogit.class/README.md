StackToRegisterMappingCogit is an optimizing code generator that eliminates a lot of stack operations and inlines some special selector arithmetic.  It does so by a simple stack-to-register mapping scheme based on deferring the generation of code to produce operands until operand-consuming operations.  The operations that consume operands are sends, stores and returns.

See methods in the class-side documentation protocol for more detail.

Instance Variables
	compilationPass:								<Integer>
	currentCallCleanUpSize:						<Integer>
	ceCall0ArgsPIC:									<Integer>
	ceCall1ArgsPIC:									<Integer>
	ceCall2ArgsPIC:									<Integer>
	ceCallCogCodePopReceiverArg0Regs:			<Integer>
	ceCallCogCodePopReceiverArg1Arg0Regs:		<Integer>
	deadCode										<Boolean>
	debugBytecodePointers:						<Set of Integer>
	debugFixupBreaks:								<Set of Integer>
	debugStackPointers:							<CArrayAccessor of (Integer|nil)>
	hasNativeFrame								<Boolean>
	methodAbortTrampolines:						<CArrayAccessor of Integer>
	methodOrBlockNumTemps:						<Integer>
	numPushNilsFunction:							<Symbol>
	optStatus:										<Integer>
	picAbortTrampolines:							<CArrayAccessor of Integer>
	picMissTrampolines:							<CArrayAccessor of Integer>
	pushNilSizeFunction:							<Symbol>
	realCECallCogCodePopReceiverArg0Regs:		<Integer>
	realCECallCogCodePopReceiverArg1Arg0Regs:	<Integer>
	regArgsHaveBeenPushed:						<Boolean>
	simNativeSpillBase:								<Integer>
	simNativeStack:								<CArrayAccessor of CogSimStackNativeEntry>
	simNativeStackPtr:								<Integer>
	simNativeStackSize:							<Integer>
	simSelf:											<CogSimStackEntry>
	simSpillBase:									<Integer>
	simStack:										<CArrayAccessor of CogSimStackEntry>
	simStackPtr:									<Integer>
	traceSimStack:									<Integer>
	useTwoPaths									<Boolean>

compilationPass
	- counter indicating whether on the first pass through bytecodes in a V3-style embedded block or not.  The V3 closure implementation uses pushNil to initialize temporary variables and this makes an initial pushNil ambiguous.  With the V3 bytecode set, the JIT must compile to the end of the block to discover if a pushNil is for initializing a temp or to produce an operand.

currentCallCleanUpSize
	- the number of bytes to remove from the stack in a Lowcode call.

ceCall0ArgsPIC ceCall1ArgsPIC ceCall2ArgsPIC
	- the trampoline for entering an N-arg PIC

ceCallCogCodePopReceiverArg0Regs ceCallCogCodePopReceiverArg1Arg0Regs
	- the trampoline for invokinging a method with N register args
	
debugBytecodePointers
	- a Set of bytecode pcs for setting breakpoints (simulation only)

deadCode
	- set to true to indicate that the next bytecode (up to the next fixup) is not reachable.  Used to avoid generating dead code.

debugFixupBreaks
	- a Set of fixup indices for setting breakpoints (simulation only)

debugStackPointers
	- an Array of stack depths for each bytecode for code verification

hasNativeFrame
	- set to true when Lowcode creates a native stack frame for Lowcode callouts.

methodAbortTrampolines
	- a CArrayAccessor of abort trampolines for 0, 1, 2 and N args

methodOrBlockNumTemps
	- the number of method or block temps (including args) in the current compilation unit (method or block)

optStatus
	- the variable used to track the status of ReceiverResultReg for avoiding reloading that register with self between adjacent inst var accesses

numPushNilsFunction
	- the function used to determine the number of push nils at the beginning of a block.  This abstracts away from the specific bytecode set(s).

picAbortTrampolines
	- a CArrayAccessor of abort trampolines for 0, 1, 2 and N args

picMissTrampolines
	- a CArrayAccessor of abort trampolines for 0, 1, 2 and N args

pushNilSizeFunction
	- the function used to determine the number of bytes in the push nils bytecode(s) at the beginning of a block.  This abstracts away from the specific bytecode set(s).

realCECallCogCodePopReceiverArg0Regs realCECallCogCodePopReceiverArg1Arg0Regs
	- the real trampolines for invoking machine code with N reg args when in the Debug regime

regArgsHaveBeenPushed
	- whether the register args have been pushed before frame build (e.g. when an interpreter primitive is called)

simNativeSpillBase
	- the variable tracking how much of the Lowcode simulation stack has been spilled to the real stack

simNativeStack
	- the Lowcode simulation stack itself

simNativeStackPtr
	- the pointer to the top of the Lowcode simulation stack

simNativeStackSize
	- the size of the Lowcode stack so far

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
