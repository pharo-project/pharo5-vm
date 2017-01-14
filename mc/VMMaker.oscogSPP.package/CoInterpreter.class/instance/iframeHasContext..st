frame access
iframeHasContext: theFP
	"See encodeFrameFieldHasContext:numArgs:"
	<inline: true>
	<var: #theFP type: #'char *'>
	^(stackPages byteAt: theFP + FoxIFrameFlags + 2) ~= 0