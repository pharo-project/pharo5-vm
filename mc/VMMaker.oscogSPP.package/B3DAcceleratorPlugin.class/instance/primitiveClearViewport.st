primitives-renderer
primitiveClearViewport
	| result handle pv rgba |
	<export: true>
	interpreterProxy methodArgumentCount = 3
		ifFalse:[^interpreterProxy primitiveFail].
	pv := interpreterProxy positive32BitValueOf: (interpreterProxy stackValue: 0).
	rgba := interpreterProxy positive32BitValueOf: (interpreterProxy stackValue: 1).
	handle := interpreterProxy stackIntegerValue: 2.
	interpreterProxy failed ifTrue:[^nil].
	result := self cCode:'b3dxClearViewport(handle, rgba, pv)'.
	result ifFalse:[^interpreterProxy primitiveFail].
	^interpreterProxy pop: 3. "pop args; return rcvr"