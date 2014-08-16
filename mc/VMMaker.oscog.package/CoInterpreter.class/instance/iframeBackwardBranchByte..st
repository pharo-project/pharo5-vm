frame access
iframeBackwardBranchByte: theFP
	"See encodeFrameFieldHasContext:numArgs: and ifBackwardsCheckForEvents:"
	<inline: true>
	<var: #theFP type: #'char *'>
	^stackPages byteAt: theFP + (VMBIGENDIAN ifTrue: [FoxIFrameFlags + BytesPerWord - 1] ifFalse: [FoxIFrameFlags])