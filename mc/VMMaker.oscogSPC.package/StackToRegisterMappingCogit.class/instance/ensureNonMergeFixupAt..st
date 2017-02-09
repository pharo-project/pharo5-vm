compile abstract instructions
ensureNonMergeFixupAt: targetIndex
	"Make sure there's a flagged fixup at the targetIndex (pc relative to first pc) in fixups.
	 Initially a fixup's target is just a flag.  Later on it is replaced with a proper instruction."
	<returnTypeC: #'BytecodeFixup *'>
	| fixup |
	<var: #fixup type: #'BytecodeFixup *'>
	fixup := self fixupAt: targetIndex.
	fixup notAFixup ifTrue:
		[fixup becomeNonMergeFixup].
	self cCode: '' inSmalltalk:
		[fixup isMergeFixupOrIsFixedUp ifTrue:
			[self assert:
					(fixup isBackwardBranchFixup
					 or: [fixup simStackPtr = (self debugStackPointerFor: targetIndex + initialPC)])]].
	fixup recordBcpc: bytecodePC.
	^fixup