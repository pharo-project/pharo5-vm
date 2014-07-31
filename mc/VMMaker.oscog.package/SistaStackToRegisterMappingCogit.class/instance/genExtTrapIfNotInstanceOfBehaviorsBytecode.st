bytecode generators
genExtTrapIfNotInstanceOfBehaviorsBytecode
	"SistaV1: *	236		11101100	iiiiiiii		Trap If Not Instance Of Behavior/Array Of Behavior #iiiiiiii (+ Extend A * 256, where Extend A >= 0)"
	| litIndex literal branches label numBranches |
	<var: #branches type: #'AbstractInstruction **'>
	self ssStorePop: false toPreferredReg: ReceiverResultReg.
	litIndex := extA * 256 + byte1.
	extA := 0.
	literal := self getLiteral: litIndex.
	numBranches := (objectMemory isArrayNonImm: literal)
						ifTrue: [objectMemory numSlotsOf: literal]
						ifFalse: [1].
	branches := self alloca: numBranches type: (self cCoerceSimple: CogAbstractInstruction to: #'AbstractInstruction *').
	(objectMemory isArrayNonImm: literal)
		ifTrue: [objectRepresentation branchIfInstanceOfBehaviors: literal branches: branches]
		ifFalse: [objectRepresentation branchIfInstanceOfBehavior: literal branches: branches].
	"Only flush teh stack if the class trap traps.  Use ssFlushNoUpdateTo: so we continue compiling as if
	 the stack had not been fliushed.  Control does not return after the ceClassTrapTrampoline call."
	self ssFlushNoUpdateTo: simStackPtr.
	self CallRT: ceClassTrapTrampoline.
	label := self Label.
	0 to: numBranches - 1 do:
		[:i|
		(branches at: i) jmpTarget: label].
	^0