converting
asInteger
	"Answer an integer representation of this image format suitable for storage
	in an image file header. The stored value in the file header will be used when
	loading the image from the snapshot file."

	| val |
	val := wordSize = 4
		ifTrue: [6502]
		ifFalse: [68000].
	self requiresClosureSupport ifTrue: [val := val + 2].
	self requiresNativeFloatWordOrder ifTrue: [val := val + 1].
	self requiresSpurSupport ifTrue: [val := val + 2r10000].
	self requiresNewSpur64TagAssignment ifTrue: [val := val + 2].
	^val
