frame access
setIFrameHasContext: theFP
	"See encodeFrameFieldHasContext:numArgs:"
	<inline: true>
	<var: #theFP type: #'char *'>
	stackPages byteAt: theFP + FoxIFrameFlags + 2 put: 1