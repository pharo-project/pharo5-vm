compile abstract instructions
ensureNonMergeFixupAt: targetPC
	"Make sure there's a flagged fixup at the target pc in fixups.
	 Initially a fixup's target is just a flag.  Later on it is replaced with a proper instruction.
	 Override to remember the simStack state at the target, if not already there."
	"self printSimStack; printSimStack: fixup mergeSimStack"
	| fixup |
	fixup := super ensureNonMergeFixupAt: targetPC.
	fixup mergeSimStack
		ifNil: [self setMergeSimStackOf: fixup]
		ifNotNil: [self assert: simStackPtr = fixup simStackPtr.
				self deny: (self mergeRequiredToTarget: fixup mergeSimStack)].
	optStatus isReceiverResultRegLive ifFalse:
		[fixup isReceiverResultRegSelf: false].
	^fixup