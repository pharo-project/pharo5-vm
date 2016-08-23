primitives-renderer
primitiveSetFog
	| result handle rgba density fogType stop start |
	<export: true>
	<var: #density type:'double'>
	<var: #start type: 'double'>
	<var: #stop type: 'double'>
	interpreterProxy methodArgumentCount = 6
		ifFalse:[^interpreterProxy primitiveFail].
	rgba := interpreterProxy positive32BitValueOf: (interpreterProxy stackValue: 0).
	stop := interpreterProxy floatValueOf: (interpreterProxy stackValue: 1).
	start := interpreterProxy floatValueOf: (interpreterProxy stackValue: 2).
	density := interpreterProxy floatValueOf: (interpreterProxy stackValue: 3).
	fogType := interpreterProxy stackIntegerValue: 4.
	handle := interpreterProxy stackIntegerValue: 5.
	interpreterProxy failed ifTrue:[^nil].
	result := self cCode:'b3dxSetFog(handle, fogType, density, start, stop, rgba)'.
	result ifFalse:[^interpreterProxy primitiveFail].
	^interpreterProxy pop: 6. "pop args; return rcvr"