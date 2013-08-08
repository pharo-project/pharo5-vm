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
		 (fixup targetInstruction asUnsignedInteger > 1
		  and: [fixup simStackPtr > -2]) ifTrue: "ignore backward branch targets"
				[self assert: fixup simStackPtr = simStackPtr]].
	fixup targetInstruction asUnsignedInteger <= 1
		ifTrue: "convert a non-merge into a merge"
			[fixup targetInstruction: (self cCoerceSimple: 2 to: #'AbstractInstruction *').
			 fixup simStackPtr: simStackPtr]
		ifFalse:
			[fixup simStackPtr <= -2
				ifTrue: ["this is the target of a backward branch and
						 so doesn't have a simStackPtr assigned yet."
						fixup simStackPtr: simStackPtr]
				ifFalse: [self assert: fixup simStackPtr = simStackPtr]].
	^fixup