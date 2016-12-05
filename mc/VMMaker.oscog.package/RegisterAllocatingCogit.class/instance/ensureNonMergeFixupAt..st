compile abstract instructions
ensureNonMergeFixupAt: targetIndex
	"Make sure there's a flagged fixup at the targetIndex (pc relative to first pc) in fixups.
	 Initially a fixup's target is just a flag.  Later on it is replaced with a proper instruction."
	| fixup |
	fixup := super ensureNonMergeFixupAt: targetIndex.
	fixup mergeSimStack ifNil: [self setMergeSimStackOf: fixup].
	^fixup