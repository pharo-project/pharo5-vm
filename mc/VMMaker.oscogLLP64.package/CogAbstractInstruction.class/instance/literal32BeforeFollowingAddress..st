inline cacheing
literal32BeforeFollowingAddress: followingAddress
	"Answer the constant loaded by the instruction sequence just before this address:"
	<inline: true>
	^objectMemory wordSize = 8
		ifTrue: [self subclassResponsibility]
		ifFalse: [self literalBeforeFollowingAddress: followingAddress]