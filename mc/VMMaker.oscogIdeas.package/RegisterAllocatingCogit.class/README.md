RegisterAllocatingCogit is an optimizing code generator that is specialized for register allocation.

On the contrary to StackToRegisterMappingCogit, RegisterAllocatingCogit keeps at each control flow merge point the state of the simulated stack to merge into and not only an integer fixup. Each branch and jump record the current state of the simulated stack, and each fixup is responsible for merging this state into the saved simulated stack.

Instance Variables
	ceSendMustBeBooleanAddFalseLongTrampoline:		<Integer>
	ceSendMustBeBooleanAddTrueLongTrampoline:		<Integer>
	mergeSimStacksBase:									<Integer>
	nextFixup:												<Integer>
	numFixups:												<Integer>
	scratchOptStatus:										<CogSSOptStatus>
	scratchSimStack:										<Array of CogRegisterAllocatingSimStackEntry>
	scratchSpillBase:										<Integer>

ceSendMustBeBooleanAddFalseLongTrampoline
	- the must-be-boolean trampoline for long jump false bytecodes (the existing ceSendMustBeBooleanAddFalseTrampoline is used for short branches)

ceSendMustBeBooleanAddTrueLongTrampoline
	- the must-be-boolean trampoline for long jump true bytecodes (the existing ceSendMustBeBooleanAddTrueTrampoline is used for short branches)

mergeSimStacksBase
	- the base address of the alloca'ed memory for merge fixups

nextFixup
	- the index into mergeSimStacksBase from which the next needed mergeSimStack will be allocated

numFixups
	- a conservative (over) estimate of the number of merge fixups needed in a method

scratchOptStatus
	- a scratch variable to hold the state of optStatus while merge code is generated

scratchSimStack
	- a scratch variable to hold the state of simStack while merge code is generated

scratchSpillBase
	- a scratch variable to hold the state of spillBase while merge code is generated