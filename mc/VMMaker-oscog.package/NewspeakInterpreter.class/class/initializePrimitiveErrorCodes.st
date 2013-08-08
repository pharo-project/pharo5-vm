initialization
initializePrimitiveErrorCodes
	"NewspeakInterpreter initializePrimitiveErrorCodes"
	| pet |
	PrimErrTableIndex := 51. "Zero-relative"
	pet := Smalltalk specialObjectsArray at: PrimErrTableIndex + 1.
	PrimNoErr := 0. "for helper methods that need to answer success or an error code."
	PrimErrGenericFailure	:= pet indexOf: nil.
	PrimErrBadReceiver	:= pet indexOf: #'bad receiver'.
	PrimErrBadArgument	:= pet indexOf: #'bad argument'.
	PrimErrBadIndex		:= pet indexOf: #'bad index'.
	PrimErrBadNumArgs	:= pet indexOf: #'bad number of arguments'.
	PrimErrInappropriate	:= pet indexOf: #'inappropriate operation'.
	PrimErrUnsupported	:= pet indexOf: #'unsupported operation'.
	PrimErrNoModification	:= pet indexOf: #'no modification'.
	PrimErrNoMemory		:= pet indexOf: #'insufficient object memory'.
	PrimErrNoCMemory	:= pet indexOf: #'insufficient C memory'.
	PrimErrNotFound		:= pet indexOf: #'not found'