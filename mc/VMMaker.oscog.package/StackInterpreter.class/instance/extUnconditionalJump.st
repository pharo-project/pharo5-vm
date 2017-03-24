jump bytecodes
extUnconditionalJump
	"242		11110010	i i i i i i i i	Jump i i i i i i i i (+ Extend B * 256, where bbbbbbbb = sddddddd, e.g. -32768 = i=0, a=0, s=1)"
	| byte offset bcpcDelta |
	byte := self fetchByte.
	offset := byte + (extB << 8).
	bcpcDelta := offset < 0 ifTrue: [numExtB * 2] ifFalse: [0].
	extB := 0.
	numExtB := 0.
	localIP := localIP + offset.
	self ifBackwardsCheckForEvents: offset + bcpcDelta.
	self fetchNextBytecode