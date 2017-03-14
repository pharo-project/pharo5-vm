in-line cacheing
classForInlineCacheTag: inlineCacheTag
	"Character gets mapped to zero.  See inlineCacheTagForInstance:."
	^objectMemory classOrNilAtIndex: (inlineCacheTag = 0
											ifTrue: [objectMemory characterTag]
											ifFalse: [inlineCacheTag])