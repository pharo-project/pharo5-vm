frame access
iframeIsBlockActivation: theFP "<Integer>"
	<inline: true>
	<var: #theFP type: #'char *'>
	^(stackPages byteAt: theFP + FoxIFrameFlags + 3) ~= 0