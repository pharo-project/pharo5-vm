bytecode generator support
genJumpIf: boolean to: targetBytecodePC
	"The heart of performance counting in Sista.  Conditional branches are 6 times less
	 frequent than sends and can provide basic block frequencies (send counters can't).
	 Each conditional has a 32-bit counter split into an upper 16 bits counting executions
	 and a lower half counting untaken executions of the branch.  Executing the branch
	 decrements the upper half, tripping if the count goes negative.  Not taking the branch
	 decrements the lower half.  N.B. We *do not* eliminate dead branches (true ifTrue:/true ifFalse:)
	 so that scanning for send and branch data is simplified and that branch data is correct."
	<inline: false>
	| desc ok counterAddress countTripped retry counterReg |
	<var: #ok type: #'AbstractInstruction *'>
	<var: #desc type: #'CogSimStackEntry *'>
	<var: #retry type: #'AbstractInstruction *'>
	<var: #countTripped type: #'AbstractInstruction *'>

	(coInterpreter isOptimizedMethod: methodObj) ifTrue: [ ^ super genJumpIf: boolean to: targetBytecodePC ].

	self ssFlushTo: simStackPtr - 1.
	desc := self ssTop.
	self ssPop: 1.
	desc popToReg: TempReg.

	"We prefer calleeSaved to avoid saving it across the trap trip trampoline"
	counterReg := self allocateRegPreferringCalleeSavedNotConflictingWith: 0. 
	retry := self Label.
	self 
		genExecutionCountLogicInto: [ :cAddress :countTripBranch | 
			counterAddress := cAddress. 
			countTripped := countTripBranch ] 
		counterReg: counterReg.
	counterIndex := counterIndex + 1.

	"Cunning trick by LPD.  If true and false are contiguous subtract the smaller.
	 Correct result is either 0 or the distance between them.  If result is not 0 or
	 their distance send mustBeBoolean."
	self assert: (objectMemory objectAfter: objectMemory falseObject) = objectMemory trueObject.
	self annotate: (self SubCw: boolean R: TempReg) objRef: boolean.
	self JumpZero: (self ensureFixupAt: targetBytecodePC - initialPC).

	self genFallsThroughCountLogicCounterReg: counterReg counterAddress: counterAddress.

	self CmpCq: (boolean == objectMemory falseObject
					ifTrue: [objectMemory trueObject - objectMemory falseObject]
					ifFalse: [objectMemory falseObject - objectMemory trueObject])
		R: TempReg.
	ok := self JumpZero: 0.
	self MoveCq: 0 R: counterReg. "if counterReg is 0 this is a mustBeBoolean, not a counter trip."

	self flag: 'Hi Clément.  You can''t just save things to the Smalltalk stack.  You can /only/ save things that execution expects to be there on a context''s stack, because this frame may get mapped to a context object and then back, and gc''ed etc.  The counter reg does not contain an object so is a complete no-no on the Smalltalk stack.  On the C stack in the trampoline is OK, not on the Smalltalk stack in method execution.  So instead of saving and restoring the counterReg around the call, something we can''t do, we can reload it after the call'.
	false ifTrue:
		["If counterReg is caller saved then save it"
		(self register: counterReg isInMask: callerSavedRegMask) ifTrue: [ self PushR: counterReg ]].

	countTripped jmpTarget:
		(self CallRT: (boolean == objectMemory falseObject
						ifTrue: [ceSendMustBeBooleanAddFalseTrampoline]
						ifFalse: [ceSendMustBeBooleanAddTrueTrampoline])).
						
	"If we're in an image which hasn't got the Sista code loaded then the ceCounterTripped:
	 trampoline will return directly to machine code, returning the boolean.  So the code should
	 jump back to the retry point. The trampoline makes sure that TempReg has been reloaded."
	self annotateBytecode: self Label.

	self flag: 'see above'.
	false ifTrue:
		["If counterReg is caller saved then restore it"
		(self register: counterReg isInMask: callerSavedRegMask) ifTrue: [ self PopR: counterReg ]].

	"Note we /can't/ save and restore the counterReg's contents around the call since the stack can
	 only contain what an interpreted context's stack would contain at the corresponding point.  The
	 counter is not an object, so can't be written to the stack. Hence we reload it after the call."
	self MoveAw: counterAddress R: counterReg.

	self Jump: retry.
	ok jmpTarget: self Label.
	^0