primitives-renderer
primitiveSetIntProperty
	| handle prop result value |
	<export: true>
	<inline: false>
	interpreterProxy methodArgumentCount = 3
		ifFalse:[^interpreterProxy primitiveFail].
	value := interpreterProxy stackIntegerValue: 0.
	prop := interpreterProxy stackIntegerValue: 1.
	handle := interpreterProxy stackIntegerValue: 2.
	result := self cCode:'b3dxSetIntProperty(handle, prop, value)'.
	result ifFalse:[^interpreterProxy primitiveFail].
	^interpreterProxy pop: 3. "args; return rcvr"
