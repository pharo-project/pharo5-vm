primitives-renderer
primitiveGetIntProperty
	| handle prop result |
	<export: true>
	<inline: false>
	interpreterProxy methodArgumentCount = 2
		ifFalse:[^interpreterProxy primitiveFail].
	prop := interpreterProxy stackIntegerValue: 0.
	handle := interpreterProxy stackIntegerValue: 1.
	result := self cCode:'b3dxGetIntProperty(handle, prop)'.
	interpreterProxy pop: 3. "args+rcvr"
	^interpreterProxy pushInteger: result