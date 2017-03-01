A CogSimStackEntry represents an object pushed on the stack, but during the partial evaluation that occurs as part of the StackToRegisterMappingCogit's compilation.  Bytecodes that produce operands (push items onto the stack) push suitably descriptive instances of CogSimStackEntry onto the simStack (simulation stack).  Bytecodes that cnsume operands (sends, assignments, returns, etc) take items off the simStack.  Hence teh generated code avoids pushing items onto the real stack, and the StackToRegisterMappngCogit can put the operands found on the simSTack in registers, etc.  Hence actual stack raffic is much reduced, a much more efficient calling convention is enabled, and so overall performance is increased.  This scheme is due to L. Peter Deutsch and extended here.

Instance Variables
	bcptr:					<Integer>
	cogit:					<StackToRegisterMappingCogit>
	constant:				<Oop>
	liveRegister:			<Integer>
	objectRepresentation:	<CogObjectRepresentation>
	offset:					<Integer>
	register:				<Integer>
	spilled:					<Boolean>
	type:					<Integer from SSBaseOffset, SSConstant, SSRegister or SSSpill>

bcptr
	- the bytecode PC at which this particular entry was created (pushed onto the stack).

cogit
	- the StackToRegisterMappingCogit using this instance

constant
	- if type = SSConstant then this is the constant's oop

liveRegister
	- unused other than for simSelf.  This is here for simSelf and for the subclass CogRegisterAllocatingSimStackEntry

objectRepresentation
	- the CogObjectRepresentation in use for the current object model

offset
	- if type = SSBaseOffset or type = SSSpill then this is the offset from register

register
	- type = SSBaseOffset or type = SSSpill or type = SSRegister then this is the register's code (NoReg, TempReg, ReceiverResultReg et al)

spilled
	- if true, then this entry has been spilled onto the actual stack (or rather code has been generated to push the entry onto the real stack)

type
	- SSBaseOffset, SSConstant, SSRegister or SSSpill