shapes-compressed
checkCompressedFills: indexList
	"Check if the indexList (containing fill handles) is okay."
	| fillPtr length fillIndex |
	<inline: false>
	<var: #fillPtr type:'int *'>
	"First check if the oops have the right format"
	(interpreterProxy isWords: indexList) ifFalse:[^false].

	"Then check the fill entries"
	length := interpreterProxy slotSizeOf: indexList.
	fillPtr := interpreterProxy firstIndexableField: indexList.
	0 to: length-1 do:[:i |
		fillIndex := fillPtr at: i.
		"Make sure the fill is okay"
		(self isFillOkay: fillIndex) ifFalse:[^false]].

	^ true