primitives-qwaq
checkVertexData: vertices
	"Check the entire vertex data to ensure no nan/inf values"
	| vtxSize vtxPtr f |
	<var: #vtxPtr type: 'float *'>
	<var: #f type: 'float'>
	vtxSize := interpreterProxy slotSizeOf: vertices.
	vtxPtr := interpreterProxy firstIndexableField: vertices.
	0 to: vtxSize-1 do:[:i|
		f := vtxPtr at: i.
		(self isnan: (f-f)) ifTrue:[^interpreterProxy primitiveFail].
	].
