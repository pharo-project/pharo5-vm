frame access
iframeBackwardBranchByte: theFP put: aByte
	"See encodeFrameFieldHasContext:numArgs: and ifBackwardsCheckForEvents:"
	<inline: true>
	<var: #theFP type: #'char *'>
	stackPages
		byteAt: theFP + (VMBIGENDIAN ifTrue: [FoxIFrameFlags + objectMemory wordSize - 1] ifFalse: [FoxIFrameFlags])
		put: aByte