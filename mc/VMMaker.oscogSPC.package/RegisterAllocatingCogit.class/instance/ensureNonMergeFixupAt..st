compile abstract instructions
ensureNonMergeFixupAt: targetPC
	"Make sure there's a flagged fixup at the target pc in fixups.
	 Initially a fixup's target is just a flag.  Later on it is replaced with a proper instruction.
	 Override to remember the simStack state at tyeh target, if required."
	| fixup |
	fixup := super ensureNonMergeFixupAt: targetPC.
	fixup mergeSimStack ifNil: [self setMergeSimStackOf: fixup].
	^fixup