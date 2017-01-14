primitives-qwaq
checkBoundsRange: vertices faces: facePtr count: faceCount
	"Verify the bounds condition on the entire faces array"
	| vtxSize |
	<var: #facePtr type: 'unsigned int *'>
	vtxSize := (interpreterProxy slotSizeOf: vertices) / 3.
	0 to: faceCount-1 do:[:i|
		(facePtr at: i) > vtxSize
			ifTrue:[^interpreterProxy primitiveFail]].
