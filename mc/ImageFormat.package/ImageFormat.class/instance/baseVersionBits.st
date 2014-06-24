private
baseVersionBits
	"Answer the bits associated with base format number exclusive of capability bits"

	^self baseVersionBitsOf: self asInteger
