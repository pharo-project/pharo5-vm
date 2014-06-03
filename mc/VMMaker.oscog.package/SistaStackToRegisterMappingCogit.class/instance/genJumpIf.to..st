bytecode generators
genJumpIf: boolean to: targetBytecodePC
	"The heart of performance counting in Sista.  Conditional branches are 6 times less
	 frequent than sends and can provide basic block frequencies (send counters can't).
	 Each conditional has a 32-bit counter split into an upper 16 bits counting executions
	 and a lower half counting untaken executions of the branch.  Executing the branch
	 decrements the upper half, tripping if the count goes negative.  Not taking the branch
	 decrements the lower half.  N.B. We *do not* eliminate dead branches (true ifTrue:/true ifFalse:)
	 so that scanning for send and branch data is simplified and that branch data is correct."
	<inline: false>
	| desc ok counter countTripped retry |
	<var: #desc type: #'CogSimStackEntry *'>
	<var: #ok type: #'AbstractInstruction *'>
	<var: #retry type: #'AbstractInstruction *'>
	<var: #counter type: #'AbstractInstruction *'>
	<var: #countTripped type: #'AbstractInstruction *'>
	self ssFlushTo: simStackPtr - 1.
	desc := self ssTop.
	self ssPop: 1.
	desc popToReg: TempReg.

	self ssAllocateRequiredReg: SendNumArgsReg. "Use this as the count reg."
	counter := self addressOf: (counters at: counterIndex).
	counterIndex := counterIndex + 1.
	self flag: 'will need to use MoveAw32:R: if 64 bits'.
	self assert: BytesPerWord = CounterBytes.
	retry := self MoveAw: counter asUnsignedInteger R: SendNumArgsReg.
	counter addDependent: (self annotateAbsolutePCRef: retry).
	self SubCq: 16r10000 R: SendNumArgsReg. "Count executed"
	"Don't write back if we trip; avoids wrapping count back to initial value, and if we trip we don't execute."
	countTripped := self JumpCarry: 0.
	counter addDependent: (self annotateAbsolutePCRef:
		(self MoveR: SendNumArgsReg Aw: counter asUnsignedInteger)). "write back"

	"Cunning trick by LPD.  If true and false are contiguous subtract the smaller.
	 Correct result is either 0 or the distance between them.  If result is not 0 or
	 their distance send mustBeBoolean."
	self assert: (objectMemory objectAfter: objectMemory falseObject) = objectMemory trueObject.
	self annotate: (self SubCw: boolean R: TempReg) objRef: boolean.
	self JumpZero: (self ensureFixupAt: targetBytecodePC - initialPC).

	self SubCq: 1 R: SendNumArgsReg. "Count untaken"
	counter addDependent: (self annotateAbsolutePCRef:
		(self MoveR: SendNumArgsReg Aw: counter asUnsignedInteger)). "write back"

	self CmpCq: (boolean == objectMemory falseObject
					ifTrue: [objectMemory trueObject - objectMemory falseObject]
					ifFalse: [objectMemory falseObject - objectMemory trueObject])
		R: TempReg.
	ok := self JumpZero: 0.
	self MoveCq: 0 R: SendNumArgsReg. "if SendNumArgsReg is 0 this is a mustBeBoolean, not a counter trip."
	countTripped jmpTarget:
		(self CallRT: (boolean == objectMemory falseObject
						ifTrue: [ceSendMustBeBooleanAddFalseTrampoline]
						ifFalse: [ceSendMustBeBooleanAddTrueTrampoline])).
	"If we're in an image which hasn't got the Sista code loaded then the ceCounterTripped:
	 trampoline will return directly to machine code, returning the boolean.  So the code should
	 jump back to the retry point. The trampoline makes sure that TempReg has been reloaded."
	self annotateBytecode: self Label.
	self Jump: retry.
	ok jmpTarget: self Label.
	^0