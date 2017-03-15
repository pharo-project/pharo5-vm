interpreter interface
loadBitBltDestForm
	"Load the dest form for BitBlt. Answer false if anything is wrong, true otherwise."

	| destBitsSize |
	<inline: true>
	destBits := interpreterProxy fetchPointer: FormBitsIndex ofObject: destForm.
	destWidth := interpreterProxy fetchInteger: FormWidthIndex ofObject: destForm.
	destHeight := interpreterProxy fetchInteger: FormHeightIndex ofObject: destForm.
	(destWidth >= 0 and: [destHeight >= 0]) ifFalse:
		[^false].
	destDepth := interpreterProxy fetchInteger: FormDepthIndex ofObject: destForm.
	destMSB := destDepth > 0.
	destDepth < 0 ifTrue:
		[destDepth := 0 - destDepth].
	"Ignore an integer bits handle for Display in which case 
	the appropriate values will be obtained by calling ioLockSurfaceBits()."
	(interpreterProxy isIntegerObject: destBits)
		ifTrue: "Query for actual surface dimensions"
			[querySurfaceFn = 0 ifTrue: [self loadSurfacePlugin ifFalse: [^false]].
			 (self query: (interpreterProxy integerValueOf: destBits)
				Sur: (self addressOf: destWidth)
				fa: (self addressOf: destHeight)
				ce: (self addressOf: destDepth)
				Fn: (self addressOf: destMSB)) ifFalse:
					[interpreterProxy primitiveFailFor: PrimErrCallbackError.
					 ^false].
			destPPW := 32 // destDepth.
			destBits := destPitch := 0]
		ifFalse:
			[destPPW := 32 // destDepth.
			destPitch := destWidth + (destPPW-1) // destPPW * 4.
			destBitsSize := interpreterProxy byteSizeOf: destBits.
			((interpreterProxy isWordsOrBytes: destBits)
			 and: [destBitsSize >= (destPitch * destHeight)]) ifFalse:
				[^false].
			"Skip header since external bits don't have one"
			destBits := self oopForPointer: (interpreterProxy firstIndexableField: destBits)].
	^true