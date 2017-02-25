bytecode generators
genExtJumpIfNotInstanceOfBehaviorsOrPopBytecode
	"SistaV1: *	254		11111110	kkkkkkkk	jjjjjjjj		branch If Not Instance Of Behavior/Array Of Behavior kkkkkkkk (+ Extend A * 256, where Extend A >= 0) distance jjjjjjjj (+ Extend B * 256, where Extend B >= 0)"
								
	| reg literal distance targetFixUp |
	
	reg := self allocateRegForStackEntryAt: 0.
	self ssTop popToReg: reg.
	
	literal := self getLiteral: (extA * 256 + byte1).
	extA := 0.
	distance := extB * 256 + byte2.
	extB := 0.
	numExtB := 0.

	"Because ensureFixupAt: will generate code to merge with the target simStack when required, it is
	 necessary to tease apart the jump and the merge so that the merge code is only executed if the
	 branch is taken.  i.e. if merge code is required we generate
			jump not cond Lcontinue
			... merge code ...
			jump Ltarget
		Lcontinue:
	 instead of the incorrect
			... merge code ...
			jump cond Ltarget"
	(self mergeRequiredForJumpTo: bytecodePC + 3 + distance) ifTrue:
		[self shouldBeImplemented].

	targetFixUp := self cCoerceSimple: (self ensureFixupAt: bytecodePC + 3 + distance) to: #'AbstractInstruction *'.
		
	(objectMemory isArrayNonImm: literal)
		ifTrue: [objectRepresentation branchIf: reg notInstanceOfBehaviors: literal target: targetFixUp]
		ifFalse: [objectRepresentation branchIf: reg notInstanceOfBehavior: literal target: targetFixUp].
						
	self ssPop: 1.
	
	^0