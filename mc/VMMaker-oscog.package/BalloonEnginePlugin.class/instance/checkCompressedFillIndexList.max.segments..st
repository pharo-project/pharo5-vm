shapes-compressed
checkCompressedFillIndexList: fillList max: maxIndex segments: nSegs
	"Check the fill indexes in the run-length encoded fillList"
	| length runLength runValue nFills fillPtr |
	<inline: false>
	<var: #fillPtr type:'int *'>
	length := interpreterProxy slotSizeOf: fillList.
	fillPtr := interpreterProxy firstIndexableField: fillList.
	nFills := 0.
	0 to: length-1 do:[:i |
		runLength := self shortRunLengthAt: i from: fillPtr.
		runValue := self shortRunValueAt: i from: fillPtr.
		(runValue >= 0 and:[runValue <= maxIndex]) ifFalse:[^false].
		nFills := nFills + runLength.
	].
	^nFills = nSegs