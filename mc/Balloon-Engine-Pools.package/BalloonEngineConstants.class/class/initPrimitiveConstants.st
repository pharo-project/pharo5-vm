pool definition
initPrimitiveConstants
	"Initialize the primitive constants"

	"Primitive type constants"
	GEPrimitiveUnknown := 0.
	GEPrimitiveEdgeMask := 16rFF.
	GEPrimitiveFillMask := 16rFF00.
	GEPrimitiveTypeMask := 16rFFFF.

	"General state constants (Note: could be compressed later)"
	GEObjectType := 0.				"Type of object"
	GEObjectLength := 1.			"Length of object"
	GEObjectIndex := 2.			"Index into external objects"
	GEObjectUnused := 3.			"Currently unused"

	"Primitive failure codes"
	GEFAlreadyFailed := 100.

	GEFEngineIsInteger := 101.
	GEFEngineIsWords := 102.
	GEFEngineTooSmall := 103.
	GEFEngineStopped := 104.

	GEFWorkBufferIsInteger := 105.
	GEFWorkBufferIsPointers := 106.
	GEFWorkBufferTooSmall := 107.
	GEFWorkBufferBadMagic := 108.
	GEFWorkBufferWrongSize := 109.
	GEFWorkBufferStartWrong := 110.
	GEFWorkTooBig := 111.

	GEFEdgeDataTooSmall := 112.
	GEFFillDataTooSmall := 113.
	GEFClassMismatch := 114.
	GEFSizeMismatch := 115.
	GEFWrongState := 116.
	GEFWrongFill := 117.
	GEFWrongEdge := 118.

	GEFEntityLoadFailed := 119.
	GEFEntityCheckFailed := 120.
	GEFBadPoint := 121.
	GEFBitBltLoadFailed := 122.
	GEFFormLoadFailed := 123