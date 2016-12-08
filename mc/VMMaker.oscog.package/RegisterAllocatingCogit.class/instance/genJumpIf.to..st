bytecode generator support
genJumpIf: boolean to: targetBytecodePC
	<inline: false>
	| desc reg fixup ok |
	<var: #desc type: #'CogSimStackEntry *'>
	<var: #fixup type: #'BytecodeFixup *'>
	<var: #ok type: #'AbstractInstruction *'>
	desc := self ssTop.
	self ssPop: 1.
	(desc type == SSConstant
	 and: [desc constant = objectMemory trueObject or: [desc constant = objectMemory falseObject]]) ifTrue:
		["Must arrange there's a fixup at the target whether it is jumped to or
		  not so that the simStackPtr can be kept correct."
		 fixup := self ensureFixupAt: targetBytecodePC - initialPC.
		 "Must annotate the bytecode for correct pc mapping."
		 self annotateBytecode: (desc constant = boolean
									ifTrue: [self Jump: fixup]
									ifFalse: [self prevInstIsPCAnnotated
												ifTrue: [self Nop]
												ifFalse: [self Label]]).
		 extA := 0.
		 ^0].
	"try and use the top entry's register if anty, but only if it can be destroyed."
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
	self genSubConstant: boolean R: reg.
	self JumpZero: (self ensureFixupAt: targetBytecodePC - initialPC).
	
	self extASpecifiesNoMustBeBoolean ifTrue: 
		[extA := 0. 
		 self annotateBytecode: self lastOpcode.
		 ^0].
	extA := 0.
	
.	self CmpCq: (boolean = objectMemory falseObject
					ifTrue: [objectMemory trueObject - objectMemory falseObject]
					ifFalse: [objectMemory falseObject - objectMemory trueObject])
		R: reg.
	ok := self JumpZero: 0.
	reg ~= TempReg ifTrue:
		[self MoveR: reg R: TempReg].
	self copySimStackToScratch: simSpillBase.
	self ssFlushTo: simStackPtr.
	self genCallMustBeBooleanFor: boolean.
	"NOTREACHED"
	ok jmpTarget: (self annotateBytecode: self Label).
	self restoreSimStackFromScratch.
	^0