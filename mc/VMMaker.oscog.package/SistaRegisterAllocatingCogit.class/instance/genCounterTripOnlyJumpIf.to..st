bytecode generator support
genCounterTripOnlyJumpIf: boolean to: targetBytecodePC 
	"Specific version if the branch is only reached while falling through if the counter trips after an inlined #== branch. We do not regenerate the counter logic in this case to avoid 24 bytes instructions."
	
	<var: #ok type: #'AbstractInstruction *'>
	<var: #mustBeBooleanTrampoline type: #'AbstractInstruction *'>

	| ok mustBeBooleanTrampoline |

	extA := 0.
	
	self ssTop popToReg: TempReg.
	self ssPop: 1.

	counterIndex := counterIndex + 1. "counters are increased / decreased in the inlined branch"

	"We need SendNumArgsReg because of the mustBeBooleanTrampoline"
	self ssAllocateRequiredReg: SendNumArgsReg.
	self MoveCq: 1 R: SendNumArgsReg.
	
	"The first time this is reached, it calls necessarily the counter trip for the trampoline because SendNumArgsReg is non zero"
	mustBeBooleanTrampoline := self genCallMustBeBooleanFor: boolean.

	self annotateBytecode: self Label.

	"Cunning trick by LPD.  If true and false are contiguous subtract the smaller.
	 Correct result is either 0 or the distance between them.  If result is not 0 or
	 their distance send mustBeBoolean."
	self assert: (objectMemory objectAfter: objectMemory falseObject) = objectMemory trueObject.
	self genSubConstant: boolean R: TempReg.
	self JumpZero: (self ensureFixupAt: targetBytecodePC - initialPC).

	self CmpCq: (boolean = objectMemory falseObject
					ifTrue: [objectMemory trueObject - objectMemory falseObject]
					ifFalse: [objectMemory falseObject - objectMemory trueObject])
		R: TempReg.
		
	ok := self JumpZero: 0.
	self MoveCq: 0 R: SendNumArgsReg. "if counterReg is 0 this is a mustBeBoolean, not a counter trip."		

	self Jump: mustBeBooleanTrampoline.
	
	ok jmpTarget: self Label.
	^0