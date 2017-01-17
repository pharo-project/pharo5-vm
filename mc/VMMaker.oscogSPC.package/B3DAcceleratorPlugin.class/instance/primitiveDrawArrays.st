primitives-qwaq
primitiveDrawArrays
	"Primitive. Setup non-VBO client state and call drawRangeElements in one go to avoid
	garbage collection to move the buffers underneith."
	| maxIdx minIdx mode texCoords normals colors vertices handle vtxSize ok |
	<export: true>

	interpreterProxy methodArgumentCount = 8 ifFalse:
		[^interpreterProxy primitiveFail].

	maxIdx := interpreterProxy stackIntegerValue: 0.
	minIdx := interpreterProxy stackIntegerValue: 1.
	mode := interpreterProxy stackIntegerValue: 2.
	texCoords := interpreterProxy stackValue: 3.
	normals := interpreterProxy stackValue: 4.
	colors := interpreterProxy stackValue: 5.
	vertices := interpreterProxy stackValue: 6.
	handle := interpreterProxy stackIntegerValue: 7.

	self loadClientState: handle vertices: vertices colors: colors normals: normals texCoords: texCoords.
	interpreterProxy failed ifTrue:[^nil].
	doRangeChecks ifTrue:
		["Verify the vertex data itself"
		self checkVertexData: vertices.

		"Verify min-max range in bounds for given vertex array"
		vtxSize := (interpreterProxy slotSizeOf: vertices) / 3.
		(minIdx < 0 or:[minIdx > maxIdx or:[maxIdx > vtxSize]]) ifTrue:
			[interpreterProxy primitiveFail]].
	interpreterProxy failed ifFalse:
		[ok := self cCode: 'b3dDrawArrays(handle, mode, minIdx, maxIdx)' 
					inSmalltalk:[mode. false].
		 ok ifTrue:
			[interpreterProxy pop: interpreterProxy methodArgumentCount]].
	^nil "keep compiler quiet"
