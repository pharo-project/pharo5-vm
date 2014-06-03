shapes-compressed
checkCompressedPoints: points segments: nSegments
	"Check if the given point array can be handled by the engine."
	| pSize |
	<inline: false>
	(interpreterProxy isWords: points) ifFalse:[^false].
	pSize := interpreterProxy slotSizeOf: points.
	"The points must be either in PointArray format or ShortPointArray format.
	Also, we currently handle only quadratic segments (e.g., 3 points each) and thus either
		pSize = nSegments * 3,		for ShortPointArrays or,
		pSize = nSegments * 6,		for PointArrays"
	(pSize = (nSegments * 3) or:[pSize = (nSegments * 6)]) 
		ifFalse:[^false]. "Can't handle this"
	^true