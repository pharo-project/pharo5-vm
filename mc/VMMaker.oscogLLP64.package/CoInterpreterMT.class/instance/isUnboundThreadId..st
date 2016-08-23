process primitive support
isUnboundThreadId: threadId
	"Answer if the threadId is neither affined nor bound.  Not the same as bound not."
	^threadId = objectMemory nilObject
	  or: [((objectMemory integerValueOf: threadId) bitAnd: (ThreadIdMask << 1) + 1) = 0]