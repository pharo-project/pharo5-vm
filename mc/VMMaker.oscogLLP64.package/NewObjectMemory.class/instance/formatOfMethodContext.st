frame access
formatOfMethodContext
	"Answer the class format word for MethodContext which is used to instantiate
	 contexts without needing to fetch it from the class MethodContext itself."
	^(ClassMethodContextCompactIndex << 12)
	+ (self indexablePointersFormat << self instFormatFieldLSB) "Pointers+Variable"
	+ (CtxtTempFrameStart + (self baseHeaderSize / self wordSize) << 2)