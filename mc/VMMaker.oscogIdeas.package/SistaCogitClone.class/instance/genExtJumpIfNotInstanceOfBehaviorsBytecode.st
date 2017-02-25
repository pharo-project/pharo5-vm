bytecode generators
genExtJumpIfNotInstanceOfBehaviorsBytecode
	"SistaV1: *	254		11111110	kkkkkkkk	jjjjjjjj		branch If Not Instance Of Behavior/Array Of Behavior kkkkkkkk (+ Extend A * 256, where Extend A >= 0) distance jjjjjjjj (+ Extend B * 256, where Extend B >= 0)"
	| reg literal distance targetFixUp inverse |

	"We lose the information of in which register is stack top 
	 when jitting the branch target so we need to flush everything. 
	 We could use a fixed register here...."
	reg := self allocateRegForStackEntryAt: 0.
	self ssTop popToReg: reg.
	self ssFlushTo: simStackPtr. "flushed but the value is still in reg"
	self ssPop: 1.

	literal := self getLiteral: (extA * 256 + byte1).
	(inverse := extB < 0) ifTrue:
		[extB := extB + 128].
	distance := extB * 256 + byte2.
	extA := extB := numExtB := 0.

	targetFixUp := self cCoerceSimple: (self ensureFixupAt: bytecodePC + 3 + distance) to: #'AbstractInstruction *'.
	inverse
		ifFalse: 
			[(objectMemory isArrayNonImm: literal)
				ifTrue: [objectRepresentation branchIf: reg notInstanceOfBehaviors: literal target: targetFixUp]
				ifFalse: [objectRepresentation branchIf: reg notInstanceOfBehavior: literal target: targetFixUp] ]
		ifTrue:
			[(objectMemory isArrayNonImm: literal)
				ifTrue: [objectRepresentation branchIf: reg instanceOfBehaviors: literal target: targetFixUp]
				ifFalse: [objectRepresentation branchIf: reg instanceOfBehavior: literal target: targetFixUp]].

	^0