frame access
setFrameHasContext: theFP
	"See encodeFrameFieldHasContext:numArgs:"
	<inline: true>
	<var: #theFP type: #'char *'>
	stackPages byteAt: theFP + FoxFrameFlags + 2 put: 1