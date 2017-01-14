frame access
frameNumArgs: theFP
	"See encodeFrameFieldHasContext:numArgs:"
	<inline: true>
	<var: #theFP type: #'char *'>
	^(self isMachineCodeFrame: theFP)
		ifTrue: [(self mframeCogMethod: theFP) cmNumArgs]
		ifFalse: [stackPages byteAt: theFP + FoxIFrameFlags + 1]