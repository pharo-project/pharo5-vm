objects from disk
startUpFrom: anImageSegment 
	"In this case, do we need to swap word halves when reading this segment?"

	^SmalltalkImage current endianness ~~ anImageSegment endianness 
		ifTrue: [Message selector: #swapHalves	"will be run on each instance"]
		ifFalse: [nil]