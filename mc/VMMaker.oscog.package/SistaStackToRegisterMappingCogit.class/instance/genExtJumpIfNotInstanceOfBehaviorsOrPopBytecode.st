bytecode generators
genExtJumpIfNotInstanceOfBehaviorsOrPopBytecode
	"SistaV1: *	254		11111110	kkkkkkkk	jjjjjjjj		branch If Not Instance Of Behavior/Array Of Behavior kkkkkkkk (+ Extend A * 256, where Extend A >= 0) distance jjjjjjjj (+ Extend B * 256, where Extend B >= 0)"
								
	| reg literal distance targetFixUp |
	
	reg := self allocateRegForStackTopEntry.
	self ssTop popToReg: reg.
	
	literal := self getLiteral: (extA * 256 + byte1).
	extA := 0.
	distance := extB * 256 + byte2.
	extB := 0.
	
	targetFixUp := (self ensureFixupAt: bytecodePC + 3 + distance - initialPC) asUnsignedInteger.
		
	(objectMemory isArrayNonImm: literal)
		ifTrue: [objectRepresentation branchIf: reg notInstanceOfBehaviors: literal target: targetFixUp]
		ifFalse: [objectRepresentation branchIf: reg notInstanceOfBehavior: literal target: targetFixUp].
						
	self genPopStackBytecode.
	
	^0