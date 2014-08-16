bytecode generators
genExtTrapIfNotInstanceOfBehaviorsBytecode
	"SistaV1: *	236		11101100	iiiiiiii		Trap If Not Instance Of Behavior/Array Of Behavior #iiiiiiii (+ Extend A * 256, where Extend A >= 0)"
	| reg litIndex literal branches label numBranches |
	<var: #branches type: #'AbstractInstruction **'>
	reg := self ssStorePop: true toPreferredReg: ReceiverResultReg.
	reg ~= ReceiverResultReg ifTrue:
		[self MoveR: reg R: ReceiverResultReg].
	optStatus isReceiverResultRegLive: false.
	litIndex := extA * 256 + byte1.
	extA := 0.
	literal := self getLiteral: litIndex.
	"Allow an extra branch for Spur, which may have two tag patterns for SmallInteger"
	numBranches := (objectMemory isArrayNonImm: literal)
						ifTrue: [(objectMemory numSlotsOf: literal) + 1]
						ifFalse: [2].
	branches := self alloca: numBranches type: (self cCode: [#'AbstractInstruction *'] inSmalltalk: [backEnd class]).
	numBranches := (objectMemory isArrayNonImm: literal)
						ifTrue: [objectRepresentation branchIfInstanceOfBehaviors: literal branches: branches]
						ifFalse: [objectRepresentation branchIfInstanceOfBehavior: literal branches: branches].
	"Only flush the stack if the class trap traps.  Use ssFlushNoUpdateTo: so we continue compiling as if
	 the stack had not been flushed.  Control does not return after the ceClassTrapTrampoline call."
	self ssFlushNoUpdateTo: simStackPtr.
	self CallRT: ceClassTrapTrampoline.
	label := self Label.
	0 to: numBranches - 1 do:
		[:i|
		(branches at: i) jmpTarget: label].
	^0