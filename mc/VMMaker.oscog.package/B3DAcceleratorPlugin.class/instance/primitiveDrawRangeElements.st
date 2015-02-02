primitives-qwaq
primitiveDrawRangeElements
	"Primitive. Setup non-VBO client state and call drawRangeElements in one go to avoid
	garbage collection to move the buffers underneith."
	| faces maxIdx minIdx mode texCoords normals colors vertices handle vtxSize ok facePtr faceSize |
	<export: true>
	<var: #facePtr type: 'unsigned int *'>

	interpreterProxy methodArgumentCount = 9 ifFalse:
		[^interpreterProxy primitiveFail].

	faces := interpreterProxy stackValue: 0.
	(interpreterProxy isWords: faces) ifFalse:
		[^interpreterProxy primitiveFail].
	faceSize := interpreterProxy slotSizeOf: faces.
	facePtr := interpreterProxy firstIndexableField: faces.

	maxIdx := interpreterProxy stackIntegerValue: 1.
	minIdx := interpreterProxy stackIntegerValue: 2.
	mode := interpreterProxy stackIntegerValue: 3.
	texCoords := interpreterProxy stackValue: 4.
	normals := interpreterProxy stackValue: 5.
	colors := interpreterProxy stackValue: 6.
	vertices := interpreterProxy stackValue: 7.
	handle := interpreterProxy stackIntegerValue: 8.

	self loadClientState: handle vertices: vertices colors: colors normals: normals texCoords: texCoords.
	interpreterProxy failed ifTrue:[^nil].

	doRangeChecks ifTrue:
		["Verify the vertex data itself"
		self checkVertexData: vertices.
		"Change bounds range to make sure the data is valid"
		self checkBoundsRange: vertices faces: facePtr count: faceSize.
		"Verify min-max range in bounds for given vertex array"
		vtxSize := (interpreterProxy slotSizeOf: vertices) / 3.
		(minIdx < 0 or:[minIdx > maxIdx or:[maxIdx > vtxSize]]) ifTrue:
			[interpreterProxy primitiveFail]].

	interpreterProxy failed ifFalse:
		[ok := self cCode: 'b3dDrawRangeElements(handle, mode, minIdx, maxIdx, faceSize,  facePtr)'
					inSmalltalk:[mode. facePtr. false].
		ok ifTrue:
			[interpreterProxy pop: interpreterProxy methodArgumentCount]].
	^nil "keep compiler quiet"
