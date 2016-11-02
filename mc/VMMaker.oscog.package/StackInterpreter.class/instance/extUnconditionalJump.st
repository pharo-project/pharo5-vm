jump bytecodes
extUnconditionalJump
	"242		11110010	i i i i i i i i	Jump i i i i i i i i (+ Extend B * 256, where bbbbbbbb = sddddddd, e.g. -32768 = i=0, a=0, s=1)"
	| byte offset |
	byte := self fetchByte.
	offset := byte + (extB << 8).
	extB := 0.
	localIP := localIP + offset.
	self ifBackwardsCheckForEvents: offset.
	self fetchNextBytecode