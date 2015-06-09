inline cacheing
storeLiteral: literal beforeFollowingAddress: followingAddress
	"Rewrite the long constant loaded by the instruction sequence just before this address:"
	^self subclassResponsibility