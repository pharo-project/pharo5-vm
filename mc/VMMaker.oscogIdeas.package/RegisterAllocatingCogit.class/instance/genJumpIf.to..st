bytecode generator support
genJumpIf: boolean to: targetBytecodePC
	<inline: false>
	| eventualTarget desc reg fixup ok mbb noMustBeBoolean |
	<var: #fixup type: #'BytecodeFixup *'>
	<var: #ok type: #'AbstractInstruction *'>
	<var: #desc type: #'CogSimStackEntry *'>
	<var: #mbb type: #'AbstractInstruction *'>
	eventualTarget := self eventualTargetOf: targetBytecodePC.
	desc := self ssTop.
	self ssPop: 1.

	noMustBeBoolean := self extASpecifiesNoMustBeBoolean.
	extA := 0.

	(desc type == SSConstant
	 and: [desc constant = objectMemory trueObject or: [desc constant = objectMemory falseObject]]) ifTrue:
		["Must annotate the bytecode for correct pc mapping."
		 desc constant = boolean
			ifTrue:
				[deadCode := true. "Can't fall through."
				 fixup := self ensureFixupAt: eventualTarget.
				 self annotateBytecode: (self Jump: fixup)]
		 	ifFalse:
				[self annotateBytecode: (self prevInstIsPCAnnotated
												ifTrue: [self Nop]
												ifFalse: [self Label])].
		 ^0].

	"try and use the top entry's register if any, but only if it can be destroyed."
	reg := (desc type ~= SSRegister
			or: [(self anyReferencesToRegister: desc register inAllButTopNItems: 0)
			or: [(desc register = ReceiverResultReg and: [optStatus isReceiverResultRegLive])]])
				ifTrue: [TempReg]
				ifFalse: [desc register].
	desc popToReg: reg.
	"Cunning trick by LPD.  If true and false are contiguous subtract the smaller.
	 Correct result is either 0 or the distance between them.  If result is not 0 or
	 their distance send mustBeBoolean."
	self assert: (objectMemory objectAfter: objectMemory falseObject) = objectMemory trueObject.

	"Merge required; must not generate merge code along untaken branch, so flip the order."
	(self mergeRequiredForJumpTo: eventualTarget)
		ifTrue:
			[self genSubConstant: (boolean = objectMemory trueObject
										ifTrue: [objectMemory falseObject]
										ifFalse: [objectMemory trueObject])
				R: reg.
			 ok := self JumpZero: 0.
			 self CmpCq: (boolean = objectMemory trueObject
							ifTrue: [objectMemory trueObject - objectMemory falseObject]
							ifFalse: [objectMemory falseObject - objectMemory trueObject])
				R: reg.
			 noMustBeBoolean ifTrue: 
				[self JumpZero: (self ensureFixupAt: eventualTarget). "generates merge code"
				 ok jmpTarget: (self annotateBytecode: self lastOpcode).
				 ^0].
			 mbb := self JumpNonZero: 0.
			 self Jump: (self ensureFixupAt: eventualTarget). "generates merge code"
			 mbb jmpTarget: self Label]
		ifFalse:
			[self genSubConstant: boolean R: reg.
			 self JumpZero: (self ensureFixupAt: eventualTarget).
			 noMustBeBoolean ifTrue: 
				[self annotateBytecode: self lastOpcode.
				 ^0].
			 self CmpCq: (boolean = objectMemory falseObject
							ifTrue: [objectMemory trueObject - objectMemory falseObject]
							ifFalse: [objectMemory falseObject - objectMemory trueObject])
				R: reg.
			 ok := self JumpZero: 0].

	reg ~= TempReg ifTrue:
		[self MoveR: reg R: TempReg].
	self copySimStackToScratch: simSpillBase.
	self ssFlushTo: simStackPtr.
	self genCallMustBeBooleanFor: boolean.
	"NOTREACHED"
	ok jmpTarget: (self annotateBytecode: self Label).
	self restoreSimStackFromScratch.
	^0