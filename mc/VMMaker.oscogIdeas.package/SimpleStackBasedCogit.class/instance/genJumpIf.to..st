bytecode generator support
genJumpIf: boolean to: targetBytecodePC
	<inline: false>
	"Cunning trick by LPD.  If true and false are contiguous subtract the smaller.
	 Correct result is either 0 or the distance between them.  If result is not 0 or
	 their distance send mustBeBoolean."
	| ok |
	<var: #ok type: #'AbstractInstruction *'>
	extA := 0.
	self assert: (objectMemory objectAfter: objectMemory falseObject) = objectMemory trueObject.
	self PopR: TempReg.
	self genSubConstant: boolean R: TempReg.
	self JumpZero: (self ensureFixupAt: targetBytecodePC).
	self CmpCq: (boolean == objectMemory falseObject
					ifTrue: [objectMemory trueObject - objectMemory falseObject]
					ifFalse: [objectMemory falseObject - objectMemory trueObject])
		R: TempReg.
	ok := self JumpZero: 0.
	self genCallMustBeBooleanFor: boolean.
	ok jmpTarget: (self annotateBytecode: self Label).
	^0