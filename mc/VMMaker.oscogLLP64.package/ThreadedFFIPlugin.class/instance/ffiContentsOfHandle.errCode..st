callout support
ffiContentsOfHandle: oop errCode: errCode
	"Make sure that the given oop is a valid external handle"
	<inline: true>
	((interpreterProxy isBytes: oop)
	 and: [(interpreterProxy byteSizeOf: oop) = (self sizeof: #sqInt)]) ifFalse:
		[^self ffiFail: errCode].
	^interpreterProxy fetchPointer: 0 ofObject: oop