interpreter interface
loadBitBltSourceForm
	"Load the source form for BitBlt. Return false if anything is wrong, true otherwise."
	| sourceBitsSize |
	<inline: true>
	sourceBits := interpreterProxy fetchPointer: FormBitsIndex ofObject: sourceForm.
	sourceWidth := self fetchIntOrFloat: FormWidthIndex ofObject: sourceForm.
	sourceHeight := self fetchIntOrFloat: FormHeightIndex ofObject: sourceForm.
	(sourceWidth >= 0 and: [sourceHeight >= 0])
		ifFalse: [^ false].
	sourceDepth := interpreterProxy fetchInteger: FormDepthIndex ofObject: sourceForm.
	sourceMSB := sourceDepth > 0.
	sourceDepth < 0 ifTrue:[sourceDepth := 0 - sourceDepth].
	"Ignore an integer bits handle for Display in which case 
	the appropriate values will be obtained by calling ioLockSurfaceBits()."
	(interpreterProxy isIntegerObject: sourceBits) ifTrue:[
		"Query for actual surface dimensions"
		(self querySourceSurface: (interpreterProxy integerValueOf: sourceBits))
			ifFalse:[^false].
		sourcePPW := 32 // sourceDepth.
		sourceBits := sourcePitch := 0.
	] ifFalse:[
		sourcePPW := 32 // sourceDepth.
		sourcePitch := sourceWidth + (sourcePPW-1) // sourcePPW * 4.
		sourceBitsSize := interpreterProxy byteSizeOf: sourceBits.
		((interpreterProxy isWordsOrBytes: sourceBits)
			and: [sourceBitsSize >= (sourcePitch * sourceHeight)])
			ifFalse: [^ false].
		"Skip header since external bits don't have one"
		sourceBits := self oopForPointer: (interpreterProxy firstIndexableField: sourceBits).
	].
	^true