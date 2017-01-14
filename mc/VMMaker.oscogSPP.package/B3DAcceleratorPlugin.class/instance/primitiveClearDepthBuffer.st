primitives-renderer
primitiveClearDepthBuffer
	| result handle |
	<export: true>
	interpreterProxy methodArgumentCount = 1
		ifFalse:[^interpreterProxy primitiveFail].
	handle := interpreterProxy stackIntegerValue: 0.
	interpreterProxy failed ifTrue:[^nil].
	result := self cCode:'b3dxClearDepthBuffer(handle)'.
	result ifFalse:[^interpreterProxy primitiveFail].
	^interpreterProxy pop: 1. "pop args; return rcvr"