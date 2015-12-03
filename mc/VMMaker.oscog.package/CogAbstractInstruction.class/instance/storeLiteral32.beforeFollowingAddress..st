inline cacheing
storeLiteral32: literal32 beforeFollowingAddress: followingAddress
	"Answer the constant loaded by the instruction sequence just before this address:"
	<inline: true>
	objectMemory wordSize = 8
		ifTrue: [self subclassResponsibility]
		ifFalse: [self storeLiteral: literal32 beforeFollowingAddress: followingAddress]