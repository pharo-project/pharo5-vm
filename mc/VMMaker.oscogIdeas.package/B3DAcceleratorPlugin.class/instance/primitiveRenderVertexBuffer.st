primitives-renderer
primitiveRenderVertexBuffer
	| idxCount vtxCount vtxArray idxArray texHandle primType result flags handle |
	<export: true>
	<var: #idxArray type: 'int *'>
	<var: #vtxArray type: 'float *'>

	interpreterProxy methodArgumentCount = 8
		ifFalse:[^interpreterProxy primitiveFail].
	idxCount := interpreterProxy stackIntegerValue: 0.
	vtxCount := interpreterProxy stackIntegerValue: 2.
	texHandle := interpreterProxy stackIntegerValue: 4.
	flags := interpreterProxy stackIntegerValue: 5.
	primType := interpreterProxy stackIntegerValue: 6.
	handle := interpreterProxy stackIntegerValue: 7.

	interpreterProxy failed ifTrue:[^nil].
	vtxArray := self stackPrimitiveVertexArray: 3 ofSize: vtxCount.
	idxArray := self stackPrimitiveIndexArray: 1 ofSize: idxCount validate: true forVertexSize: vtxCount.

	(vtxArray == nil or:[idxArray == nil 
		or:[primType < 1 or:[primType > 6 
			or:[interpreterProxy failed]]]])
				ifTrue:[^interpreterProxy primitiveFail].

	result := self cCode:'b3dxRenderVertexBuffer(handle, primType, flags, texHandle, vtxArray, vtxCount, idxArray, idxCount)' inSmalltalk:[false].
	result ifFalse:[^interpreterProxy primitiveFail].
	^interpreterProxy pop: 8. "pop args; return rcvr"