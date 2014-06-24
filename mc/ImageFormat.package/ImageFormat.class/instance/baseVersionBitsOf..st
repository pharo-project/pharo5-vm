private
baseVersionBitsOf: anInteger
	"Answer the bits of anInteger associated with base format number exclusive
	of capability bits"

	^ anInteger bitAnd: BaseVersionMask