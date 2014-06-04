primitives-renderer
primitiveSetVerboseLevel
	| result level |
	<export: true>
	<inline: false>
	interpreterProxy methodArgumentCount = 1
		ifFalse:[^interpreterProxy primitiveFail].
	level := interpreterProxy stackIntegerValue: 0.
	result := self cCode:'b3dxSetVerboseLevel(level)'.
	interpreterProxy pop: 2. "args+rcvr"
	^interpreterProxy pushInteger: result