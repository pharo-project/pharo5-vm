primitives-qwaq
loadClientState: handle vertices: vertices colors: colors normals: normals texCoords: texCoords
	"Common method to set up client state for some render ops"
	| vtxSize sz colorPtr normalPtr txPtr vertexPtr ok |
	<var: #colorPtr type: 'void *'>
	<var: #normalPtr type: 'void *'>
	<var: #txPtr type: 'void *'>
	<var: #vertexPtr type: 'void *'>

	colorPtr := normalPtr := txPtr := vertexPtr := nil.

	"Verify vertex data"
	(interpreterProxy isWords: vertices)
		ifFalse:[^interpreterProxy primitiveFail].
	vtxSize := (interpreterProxy slotSizeOf: vertices) / 3.

	"Verify assumptions of color, normal, texCoords data"
	(colors = interpreterProxy nilObject 
		or:[(interpreterProxy isWords: colors)
		and:[(interpreterProxy slotSizeOf: colors) = (vtxSize * 4)]])
			ifFalse:[^interpreterProxy primitiveFail].
	(normals = interpreterProxy nilObject 
		or:[(interpreterProxy isWords: normals)
		and:[(interpreterProxy slotSizeOf: normals) = (vtxSize * 3)]])
			ifFalse:[^interpreterProxy primitiveFail].
	"Don't check size for texCoords since they can be 2,3,4 elements"
	(texCoords = interpreterProxy nilObject 
		or:[(interpreterProxy isWords: texCoords)])
			ifFalse:[^interpreterProxy primitiveFail].

	"Finally submit the data to OpenGL"
	(colors = interpreterProxy nilObject) ifFalse:[
		colorPtr := interpreterProxy firstIndexableField: colors.
	].
	(normals = interpreterProxy nilObject) ifFalse:[
		normalPtr := interpreterProxy firstIndexableField: normals.
	].
	(texCoords = interpreterProxy nilObject) ifFalse:[
		sz := (interpreterProxy slotSizeOf: texCoords) / vtxSize.
		txPtr := interpreterProxy firstIndexableField: texCoords.
	].
	vertexPtr := interpreterProxy firstIndexableField: vertices.
	interpreterProxy failed ifTrue:[^nil].
	ok := self cCode:'b3dLoadClientState(handle, vertexPtr, 3, colorPtr, 4, normalPtr, 3, txPtr, sz)'
		inSmalltalk:[vertexPtr. colorPtr. normalPtr. txPtr. sz false].
	ok ifFalse:[^interpreterProxy primitiveFail].
