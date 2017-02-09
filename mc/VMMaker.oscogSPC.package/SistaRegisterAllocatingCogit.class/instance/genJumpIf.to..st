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
	| ok counterAddress countTripped retry nextPC nextDescriptor desc eventualTarget reg |
	<var: #ok type: #'AbstractInstruction *'>
	<var: #desc type: #'CogSimStackEntry *'>
	<var: #retry type: #'AbstractInstruction *'>
	<var: #countTripped type: #'AbstractInstruction *'>
	<var: #nextDescriptor type: #'BytecodeDescriptor *'>

	"In optimized code we don't generate counters to improve performance"
	(coInterpreter isOptimizedMethod: methodObj) ifTrue:
		[^super genJumpIf: boolean to: targetBytecodePC].
	
	"If the branch is reached only for the counter trip trampoline 
	(typically, var1 == var2 ifTrue: falls through to the branch only for the trampoline)
	we generate a specific path to drastically reduce the number of machine instructions"
	branchReachedOnlyForCounterTrip ifTrue: 
		[branchReachedOnlyForCounterTrip := false.
		 ^self genCounterTripOnlyJumpIf: boolean to: targetBytecodePC].

	"We detect and: / or:, if found, we don't generate the counters to avoid pathological counter slow down"
	boolean = objectMemory falseObject ifTrue:
		[ nextPC := bytecodePC + (self generatorAt: byte0) numBytes.
		  nextDescriptor := self generatorAt: (objectMemory fetchByte: nextPC ofObject: methodObj) + bytecodeSetOffset.
		  nextDescriptor generator ==  #genPushConstantTrueBytecode ifTrue: [ ^ super genJumpIf: boolean to: targetBytecodePC ].
		  nextDescriptor := self generatorAt: (objectMemory fetchByte: targetBytecodePC ofObject: methodObj) + bytecodeSetOffset.
		  nextDescriptor generator == #genPushConstantFalseBytecode ifTrue: [ ^ super genJumpIf: boolean to: targetBytecodePC ]. ].

	extA := 0. "We ignore the noMustBeBoolean flag. It should not be present in methods with counters, and if it is we don't care."

	"We don't generate counters on branches on true/false, the basicblock usage can be inferred"
	desc := self ssTop.
	(desc type == SSConstant
	 and: [desc constant = objectMemory trueObject or: [desc constant = objectMemory falseObject]]) ifTrue:
		[ ^ super genJumpIf: boolean to: targetBytecodePC ].

	eventualTarget := self eventualTargetOf: targetBytecodePC.

	self flag: 'Because of the restriction on x64 that absolute loads must target %rax, it would perhaps be a better choice to use TempReg (%rax) for the counter reg and SendNumArgsReg for the boolean.'.
	"try and use the top entry's register if any, but only if it can be destroyed."
	reg := (desc type ~= SSRegister
			or: [(self anyReferencesToRegister: desc register inAllButTopNItems: 0)
			or: [(desc register = ReceiverResultReg and: [optStatus isReceiverResultRegLive])]])
				ifTrue: [TempReg]
				ifFalse: [desc register].
	desc popToReg: reg.
	self ssPop: 1.

	"We need SendNumArgsReg because of the mustBeBooleanTrampoline"
	self ssAllocateRequiredReg: SendNumArgsReg.

	retry := self Label.
	self 
		genExecutionCountLogicInto: [ :cAddress :countTripBranch | 
			counterAddress := cAddress. 
			countTripped := countTripBranch ] 
		counterReg: SendNumArgsReg.
	counterIndex := counterIndex + 1.

	"Cunning trick by LPD.  If true and false are contiguous subtract the smaller.
	 Correct result is either 0 or the distance between them.  If result is not 0 or
	 their distance send mustBeBoolean."
	self assert: (objectMemory objectAfter: objectMemory falseObject) = objectMemory trueObject.
	self genSubConstant: boolean R: reg.
	self JumpZero: (self ensureFixupAt: eventualTarget).

	self genFallsThroughCountLogicCounterReg: SendNumArgsReg counterAddress: counterAddress.

	self CmpCq: (boolean = objectMemory falseObject
					ifTrue: [objectMemory trueObject - objectMemory falseObject]
					ifFalse: [objectMemory falseObject - objectMemory trueObject])
		R: reg.
	ok := self JumpZero: 0.
	self MoveCq: 0 R: SendNumArgsReg. "if counterReg is 0 this is a mustBeBoolean, not a counter trip."
	reg ~= TempReg ifTrue:
		[self MoveR: reg R: TempReg].
	countTripped jmpTarget: self Label.
	self copySimStackToScratch: simSpillBase.
	self ssFlushTo: simStackPtr.
	self genCallMustBeBooleanFor: boolean.
						
	"If we're in an image which hasn't got the Sista code loaded then the ceCounterTripped: trampoline
	 will return directly to machine code, returning the boolean.  So the code should jump back to the
	 retry point. The trampoline preserves register state when taking the ceCounterTripped: path."
	"Clément: For some reason if I write self annotateBytecode: (self Jump: retry) the annotation is not at the correct place."
	"Eliot: Annotations apply the the address following an instruction, and the annotation must be for the return address
	 of the call (since this is the address the run-time sees), so it must be on a label before the jump, not after the jump."
	self annotateBytecode: self Label.
	simSpillBase ~= scratchSpillBase ifTrue:
		[self assert: simSpillBase > scratchSpillBase.
		 self AddCq: simSpillBase - scratchSpillBase * objectMemory wordSize R: SPReg].
	self Jump: retry.

	ok jmpTarget: self Label.
	self restoreSimStackFromScratch.
	^0