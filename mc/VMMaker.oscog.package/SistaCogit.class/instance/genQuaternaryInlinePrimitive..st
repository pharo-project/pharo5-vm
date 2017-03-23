inline primitive generators
genQuaternaryInlinePrimitive: prim
	"Quaternary inline primitives."
	"SistaV1: 248		11111000 	iiiiiiii		mjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjj * 256) m=1 means inlined primitive, no hard return after execution.
	 See EncoderForSistaV1's class comment and StackInterpreter>>#quaternaryInlinePrimitive:"
	| needStoreCheck sourceReg stopReg objReg adjust jmp cmp isStartCst isStopCst startCst stopCst iteratorReg |
	<var: #jmp type: #'AbstractInstruction *'>
	<var: #cmp type: #'AbstractInstruction *'>
	prim = 0 ifFalse: [^EncounteredUnknownBytecode].
	
	"4000	Pointer Object>> fillFrom:to:with: The receiver is a Pointer object. the middle two arguments are smallintegers. Last argument is any object. Fills the object in between the two indexes with last argument. Receiver is guaranteed to be mutable. The pointer accesses are raw (no inst var check). If ExtB is set to 1, no store check is present. Else a single store check is done for the bulk operation. Answers the receiver."
	needStoreCheck := self sistaNeedsStoreCheck.
	extB := numExtB := 0.
	
	"Allocate reg for src, objToStore, iterator and stop."
	sourceReg := needStoreCheck 
		ifTrue: [	self ssAllocateRequiredReg: ReceiverResultReg.
				self voidReceiverResultRegContainsSelf.
				ReceiverResultReg ]
		ifFalse: [ self allocateRegForStackEntryAt: 3 notConflictingWith: self emptyRegisterMask ].
	(self ssValue: 3) popToReg: sourceReg.
	objReg := self allocateRegForStackEntryAt: 0 notConflictingWith: (self registerMaskFor: sourceReg).
	self ssTop popToReg: objReg.
	
	"Set up iterator to first index to write and stop to last index to write"
	adjust := (objectMemory baseHeaderSize >> objectMemory shiftForWord) - 1. "shift by baseHeaderSize and then move from 1 relative to zero relative"
	isStartCst := (self ssValue: 2) type = SSConstant.
	isStopCst := (self ssValue: 1) type = SSConstant.
	isStartCst ifTrue: [startCst := adjust + (objectMemory integerValueOf: (self ssValue: 2) constant)].
	isStopCst ifTrue: [stopCst := adjust + (objectMemory integerValueOf: (self ssValue: 1) constant)].
	
	(isStartCst
	and: [isStopCst
	and: [stopCst - startCst < 7 ]]) "The other path generates at least 7 instructions"
		ifTrue: ["unroll"
				startCst
					to: stopCst
					do: [ :i | self MoveMw: i r: sourceReg R: objReg ] ]
		ifFalse: ["loop"
				stopReg := self allocateRegNotConflictingWith: (self registerMaskFor: sourceReg and: objReg).
				iteratorReg := self allocateRegNotConflictingWith: (self registerMaskFor: sourceReg and: objReg and: stopReg).
				isStartCst 
					ifTrue: [ self MoveCq: startCst R: iteratorReg ]
					ifFalse: [ (self ssValue: 2) popToReg: iteratorReg. 
							 adjust ~= 0 ifTrue: [ self AddCq: adjust R: iteratorReg ] ].
				isStopCst 
					ifTrue: [ self MoveCq: stopCst R: stopReg ]
					ifFalse: [ (self ssValue: 1) popToReg: stopReg. 
							 adjust ~= 0 ifTrue: [ self AddCq: adjust R: stopReg ] ].
				cmp := self CmpR: stopReg R: iteratorReg.
				jmp := self JumpAbove: 0.
				self MoveR: objReg Xwr: iteratorReg R: sourceReg.
				self AddCq: 1 R: iteratorReg.
				self Jump: cmp.
				jmp jmpTarget: self Label].
			
	needStoreCheck ifTrue: [objectRepresentation genStoreCheckReceiverReg: sourceReg valueReg: objReg scratchReg: TempReg inFrame: true].
	
	self ssPop: 4.
	self ssPushRegister: sourceReg.
	 ^0