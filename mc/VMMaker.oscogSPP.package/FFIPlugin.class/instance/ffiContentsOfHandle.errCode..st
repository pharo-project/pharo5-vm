callout support
ffiContentsOfHandle: oop errCode: errCode
	"Make sure that the given oop is a valid external handle"
	<inline: true>
	(interpreterProxy isBytes: oop)
		ifFalse:[^self ffiFail: errCode].
	((interpreterProxy byteSizeOf: oop) == 4)
		ifFalse:[^self ffiFail: errCode].
	^interpreterProxy fetchPointer: 0 ofObject: oop