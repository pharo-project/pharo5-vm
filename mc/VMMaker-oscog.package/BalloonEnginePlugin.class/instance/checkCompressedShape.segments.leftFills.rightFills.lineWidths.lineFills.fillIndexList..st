shapes-compressed
checkCompressedShape: points segments: nSegments leftFills: leftFills rightFills: rightFills lineWidths: lineWidths lineFills: lineFills fillIndexList: fillIndexList
	"Check if the given shape can be handled by the engine. 
	Since there are a number of requirements this is an extra method."
	| maxFillIndex |
	<inline: false>
	(self checkCompressedPoints: points segments: nSegments) 
		ifFalse:[^false].
	(self checkCompressedFills: fillIndexList)
		ifFalse:[^false].
	maxFillIndex := interpreterProxy slotSizeOf: fillIndexList.
	(self checkCompressedFillIndexList: leftFills max: maxFillIndex segments: nSegments)
		ifFalse:[^false].
	(self checkCompressedFillIndexList: rightFills max: maxFillIndex segments: nSegments)
		ifFalse:[^false].
	(self checkCompressedFillIndexList: lineFills max: maxFillIndex segments: nSegments)
		ifFalse:[^false].
	(self checkCompressedLineWidths: lineWidths segments: nSegments)
		ifFalse:[^false].
	^true