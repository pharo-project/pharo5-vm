simulation stack
mergeWithFixupIfRequired: fixup
	"If this bytecode has a fixup, some kind of merge needs to be done. There are 4 cases:
		1) the bytecode has no fixup (fixup isNotAFixup)
			do nothing
		2) the bytecode has a non merge fixup
			the fixup has needsNonMergeFixup.
			The code generating non merge fixup (currently only special selector code) is responsible
				for the merge so no need to do it.
			We set deadCode to false as the instruction can be reached from jumps.
		3) the bytecode has a merge fixup, but execution flow *cannot* fall through to the merge point.
			the fixup has needsMergeFixup and deadCode = true.
			ignores the current simStack as it does not mean anything 
			restores the simStack to the state the jumps to the merge point expects it to be.
		4) the bytecode has a merge fixup and execution flow *can* fall through to the merge point.
			the fixup has needsMergeFixup and deadCode = false.
			flushes the stack to the stack pointer so the fall through execution path simStack is 
				in the state the merge point expects it to be. 
			restores the simStack to the state the jumps to the merge point expects it to be.
			
	In addition, if this is a backjump merge point, we patch the fixup to hold the current simStackPtr 
	for later assertions. self printSimStack: fixup mergeSimStack"

	<var: #fixup type: #'BytecodeFixup *'>
	"case 1"
	fixup notAFixup ifTrue: [^0].

	"case 2"
	fixup isNonMergeFixup ifTrue:
		[deadCode
			ifTrue:
				[self deny: fixup simStackPtr isNil.
				 simStackPtr := fixup simStackPtr.
				 self restoreSimStackAtMergePoint: fixup.
				 deadCode := false]
			ifFalse:
				[self flushRegistersOnlyLiveOnFallThrough: fixup].
		 ^0].

	"cases 3 and 4"
	self assert: fixup isMergeFixup.
	self traceMerge: fixup.
	deadCode 
		ifTrue: [simStackPtr := fixup simStackPtr] "case 3"
		ifFalse: [self mergeCurrentSimStackWith: fixup]. "case 4"
	"cases 3 and 4"
	deadCode := false.
	fixup isBackwardBranchFixup ifTrue:
		[self assert: fixup mergeSimStack isNil.
		 self setMergeSimStackOf: fixup].
	fixup targetInstruction: self Label.
	self assert: simStackPtr = fixup simStackPtr.
	self cCode: '' inSmalltalk:
		[self assert: fixup simStackPtr = (self debugStackPointerFor: bytecodePC)].
	self restoreSimStackAtMergePoint: fixup.
	
	^0