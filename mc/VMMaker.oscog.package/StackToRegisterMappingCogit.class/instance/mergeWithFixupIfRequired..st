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
	for later assertions."
	
	<var: #fixup type: #'BytecodeFixup *'>
	"case 1"
	fixup notAFixup ifTrue:
		[^0].

	"case 2"
	fixup isNonMergeFixup ifTrue:
		[deadCode := false. ^0].

	"cases 3 and 4"
	self assert: fixup isMergeFixup.
	self traceMerge: fixup.
	deadCode
		ifTrue: "case 3"
			["Would like to assert fixup simStackPtr >= (methodOrBlockNumTemps - 1) but can't because
			   a) the initialNils hack, b) deadCode removal allows arriving at an isBackwardBranchFixup."
			 self assert: (fixup simStackPtr >= (methodOrBlockNumTemps - 1) or: [inBlock = InVanillaBlock or: [fixup isBackwardBranchFixup]]).
			 fixup isBackwardBranchFixup ifFalse:
				[simStackPtr := fixup simStackPtr].
			 LowcodeVM ifTrue:
				[simNativeStackPtr := fixup simNativeStackPtr.
				simNativeStackSize := fixup simNativeStackSize]]
		ifFalse: "case 4"
			[self ssFlushTo: simStackPtr].

	"cases 3 and 4"
	deadCode := false.
	fixup isBackwardBranchFixup ifTrue:
		[fixup simStackPtr: simStackPtr.
		LowcodeVM ifTrue:
			[fixup simNativeStackPtr: simNativeStackPtr.
			 fixup simNativeStackSize: simNativeStackSize]].
	fixup targetInstruction: self Label.
	self assert: simStackPtr = fixup simStackPtr.
	LowcodeVM ifTrue:
		[self assert: simNativeStackPtr = fixup simNativeStackPtr.
		 self assert: simNativeStackSize = fixup simNativeStackSize].

	self cCode: '' inSmalltalk:
		[self assert: fixup simStackPtr = (self debugStackPointerFor: bytecodePC)].
	self restoreSimStackAtMergePoint: fixup.

	^0