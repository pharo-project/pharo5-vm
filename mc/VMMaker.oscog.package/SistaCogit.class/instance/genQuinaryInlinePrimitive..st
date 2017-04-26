inline primitive generators
genQuinaryInlinePrimitive: prim
	"SistaV1: 248		11111000 	iiiiiiii		mjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjj * 256) m=1 means inlined primitive, no hard return after execution.
	 See EncoderForSistaV1's class comment and StackInterpreter>>#quaternaryInlinePrimitive:"
	| srcReg destReg destIterator srcIterator limitReg jmpDestYoung instr jmpAlreadyRemembered jumpFinished singleIterator |
	<var: #jmpAlreadyRemembered type: #'AbstractInstruction *'>
	<var: #jmpDestYoung type: #'AbstractInstruction *'>
	<var: #jumpFinished type: #'AbstractInstruction *'>
	<var: #instr type: #'AbstractInstruction *'>
	prim ~= 0 ifTrue: [^EncounteredUnknownBytecode].
	
	"5000	Pointer Object>> replaceFrom: srcPos to: srcLast with: startingAt: 
	Src and dest are pointer objects. 
	ScrPos, scrLast and destLast are smallintegers. 
	Receiver is guaranteed to be mutable.  
	Both ranges are in-bounds. 
	The pointer accesses are raw (no inst var check). 
	As for the normal primitive, the copy is linear from the first field to the last field (legacy code relies on it). 
	Answers the receiver."
	singleIterator := self ssTop type = SSConstant 
						and: [(self ssValue: 3) type = SSConstant 
						and: [self ssTop constant = (self ssValue: 3) constant]].
	 srcIterator :=  self allocateRegForStackEntryAt: 0 notConflictingWith: self emptyRegisterMask.
	 self genMoveAndAdjustSSEntry: (self ssValue: 0) into: srcIterator. 
	 srcReg := self allocateRegForStackEntryAt: 1 notConflictingWith: (self registerMaskFor: srcIterator).
	 (self ssValue: 1) popToReg: srcReg.
	 limitReg := self allocateRegForStackEntryAt: 2 notConflictingWith: (self registerMaskFor: srcIterator and: srcReg).
	 self genMoveAndAdjustSSEntry: (self ssValue: 2) into: limitReg.
	singleIterator
		ifTrue: 
			[ destIterator := srcIterator ]
		ifFalse: 
			[ destIterator := self allocateRegForStackEntryAt: 3 notConflictingWith: (self registerMaskFor: srcIterator and: srcReg and: limitReg).
			  self genMoveAndAdjustSSEntry: (self ssValue: 3) into: destIterator ].
	 destReg := self allocateRegForStackEntryAt: 4 notConflictingWith: (self registerMaskFor: srcIterator and: srcReg and: limitReg and: destIterator).
	 (self ssValue: 4) popToReg: destReg.
	
	"store check"
	extB > 0 ifFalse:
		[self MoveCw: objectMemory storeCheckBoundary R: TempReg.
		 self CmpR: TempReg R: destReg.
		 jmpDestYoung := self JumpBelow: 0.
		 objectRepresentation checkRememberedInTrampoline ifFalse: 
			[jmpAlreadyRemembered := objectRepresentation genCheckRememberedBitOf: destReg scratch: TempReg].
		 objectRepresentation callStoreCheckTrampoline.
		 jmpDestYoung jmpTarget: self Label.
		 objectRepresentation checkRememberedInTrampoline ifFalse: 
			[jmpAlreadyRemembered jmpTarget: self Label]].
	extB := 0.
	
	"Fast copy - no store check"
	instr := self CmpR: destIterator R: limitReg.
	jumpFinished := self JumpBelow: 0.
	self MoveXwr: srcIterator R: srcReg R: TempReg.
	self MoveR: TempReg Xwr: destIterator R: destReg.
	self AddCq: 1 R: srcIterator.
	srcIterator ~= destIterator ifTrue: [ self AddCq: 1 R: destIterator ].
	self Jump: instr.
	jumpFinished jmpTarget: self Label.
	
	self ssPop: 5.
	self ssPushRegister: destReg.
	^ 0