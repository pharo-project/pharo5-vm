primitives-qwaq
primitiveDrawElements
	"Primitive. Setup non-VBO client state and call drawElements in one go to avoid
	garbage collection to move the buffers underneith."
	| faces mode texCoords normals colors vertices handle ok facePtr faceSize |
	<export: true>
	<var: #facePtr type: 'unsigned int *'>

	interpreterProxy methodArgumentCount = 7 ifFalse:
		[^interpreterProxy primitiveFail].

	faces := interpreterProxy stackValue: 0.
	(interpreterProxy isWords: faces) ifFalse:
		[^interpreterProxy primitiveFail].
	faceSize := interpreterProxy slotSizeOf: faces.
	facePtr := interpreterProxy firstIndexableField: faces.

	mode := interpreterProxy stackIntegerValue: 1.
	texCoords := interpreterProxy stackValue: 2.
	normals := interpreterProxy stackValue: 3.
	colors := interpreterProxy stackValue: 4.
	vertices := interpreterProxy stackValue: 5.
	handle := interpreterProxy stackIntegerValue: 6.

	self loadClientState: handle vertices: vertices colors: colors normals: normals texCoords: texCoords.
	interpreterProxy failed ifTrue:[^nil].

	doRangeChecks ifTrue:
		["Verify the vertex data itself"
		self checkVertexData: vertices.
		"Change bounds range to make sure the data is valid"
		self checkBoundsRange: vertices faces: facePtr count: faceSize].

	interpreterProxy failed ifFalse:
		[ok := self cCode: 'b3dDrawElements(handle, mode, faceSize, facePtr)'
					inSmalltalk:[mode. facePtr. false].
		 ok ifTrue:
			[interpreterProxy pop: interpreterProxy methodArgumentCount]].
	^nil "keep compiler quiet"
