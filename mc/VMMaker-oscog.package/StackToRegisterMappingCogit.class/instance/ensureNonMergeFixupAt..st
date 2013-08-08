compile abstract instructions
ensureNonMergeFixupAt: targetIndex
	"Make sure there's a flagged fixup at the targetIndex (pc relative to first pc) in fixups.
	 Initially a fixup's target is just a flag.  Later on it is replaced with a proper instruction."
	<returnTypeC: #'BytecodeFixup *'>
	| fixup |
	<var: #fixup type: #'BytecodeFixup *'>
	fixup := self fixupAt: targetIndex.
	fixup targetInstruction = 0 ifTrue:
		[fixup targetInstruction: (self cCoerceSimple: 1 to: #'AbstractInstruction *')].
	self cCode: '' inSmalltalk:
		[fixup targetInstruction asUnsignedInteger > 1 ifTrue:
			[self assert:
					(fixup simStackPtr = -2 "backward branch target"
					 or: [fixup simStackPtr = (self debugStackPointerFor: targetIndex + initialPC)])]].
	^fixup