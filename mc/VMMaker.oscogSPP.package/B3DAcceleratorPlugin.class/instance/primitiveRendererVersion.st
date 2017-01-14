primitives-renderer
primitiveRendererVersion
	<export: true>
	interpreterProxy methodArgumentCount = 0
		ifFalse:[^interpreterProxy primitiveFail].
	interpreterProxy pop: 1.
	^interpreterProxy pushInteger: 1.