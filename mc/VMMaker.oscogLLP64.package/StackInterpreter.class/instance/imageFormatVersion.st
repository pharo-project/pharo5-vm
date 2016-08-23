image save/restore
imageFormatVersion
	"Return a magic constant that changes when the image format changes.
	 Since the image reading code uses this to detect byte ordering, one
	 must avoid version numbers that are invariant under byte reversal."
	<doNotGenerate>
	self assert: (objectMemory imageFormatVersion anyMask: 16) = objectMemory hasSpurMemoryManagerAPI.
	^objectMemory imageFormatVersion