shapes-compressed
checkCompressedLineWidths: lineWidthList segments: nSegments
	"Check the run-length encoded lineWidthList matches nSegments"
	| length runLength nItems ptr |
	<inline: false>
	<var: #ptr type:'int *'>
	length := interpreterProxy slotSizeOf: lineWidthList.
	ptr := interpreterProxy firstIndexableField: lineWidthList.
	nItems := 0.
	0 to: length-1 do:[:i|
		runLength := self shortRunLengthAt: i from: ptr.
		nItems := nItems + runLength.
	].
	^nItems = nSegments