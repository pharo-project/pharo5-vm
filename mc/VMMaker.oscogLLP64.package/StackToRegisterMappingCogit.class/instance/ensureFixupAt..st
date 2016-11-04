compile abstract instructions
ensureFixupAt: targetIndex
	"Make sure there's a flagged fixup at the targetIndex (pc relative to first pc) in fixups.
	 Initially a fixup's target is just a flag.  Later on it is replaced with a proper instruction."
	<returnTypeC: #'BytecodeFixup *'>
	| fixup |
	<var: #fixup type: #'BytecodeFixup *'>
	fixup := self fixupAt: targetIndex.
	self traceFixup: fixup.
	self cCode: '' inSmalltalk:
		[self assert: simStackPtr = (self debugStackPointerFor: targetIndex + initialPC).
		 (fixup isMergeFixupOrIsFixedUp
		  and: [fixup isBackwardBranchFixup not]) ifTrue: "ignore backward branch targets"
			[self assert: fixup simStackPtr = simStackPtr]].
	fixup isNonMergeFixupOrNotAFixup
		ifTrue: "convert a non-merge into a merge"
			[fixup becomeMergeFixup.
			 fixup simStackPtr: simStackPtr.
			 LowcodeVM ifTrue: [
				 fixup simNativeStackPtr: simNativeStackPtr.
				 fixup simNativeStackSize: simNativeStackSize.]]
		ifFalse:
			[fixup isBackwardBranchFixup
				ifTrue: ["this is the target of a backward branch and
						 so doesn't have a simStackPtr assigned yet."
						fixup simStackPtr: simStackPtr.
			 			LowcodeVM ifTrue: [
				 			fixup simNativeStackPtr: simNativeStackPtr.
				 			fixup simNativeStackSize: simNativeStackSize.]]
				ifFalse: [
					self assert: fixup simStackPtr = simStackPtr.
					LowcodeVM ifTrue: [
				 		self assert: fixup simNativeStackPtr = simNativeStackPtr.
		 			 	self assert: fixup simNativeStackSize = simNativeStackSize.]]].
	^fixup