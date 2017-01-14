frame access
frameIsBlockActivation: theFP "<Integer>"
	<inline: true>
	<var: #theFP type: #'char *'>
	^(stackPages byteAt: theFP + FoxFrameFlags + 3) ~= 0