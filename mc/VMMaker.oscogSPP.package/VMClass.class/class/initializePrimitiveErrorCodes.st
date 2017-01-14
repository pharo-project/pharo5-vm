initialization
initializePrimitiveErrorCodes
	"Define the VM's primitive error codes.  N.B. these are
	 replicated in platforms/Cross/vm/sqVirtualMachine.h."
	"VMClass initializePrimitiveErrorCodes"
	| pet |
	PrimErrTableIndex := 51. "Zero-relative"
	"See SmalltalkImage>>recreateSpecialObjectsArray for the table definition.
	 If the table exists and is large enough the corresponding entry is returned as
	 the primitive error, otherwise the error is answered numerically."
	pet := Smalltalk specialObjectsArray at: PrimErrTableIndex + 1 ifAbsent: [#()].
	pet isArray ifFalse: [pet := #()].
	PrimNoErr := 0. "for helper methods that need to answer success or an error code."
	PrimErrGenericFailure		:= pet indexOf: nil ifAbsent: 1.
	PrimErrBadReceiver			:= pet indexOf: #'bad receiver' ifAbsent: 2.
	PrimErrBadArgument		:= pet indexOf: #'bad argument' ifAbsent: 3.
	PrimErrBadIndex			:= pet indexOf: #'bad index' ifAbsent: 4.
	PrimErrBadNumArgs		:= pet indexOf: #'bad number of arguments' ifAbsent: 5.
	PrimErrInappropriate		:= pet indexOf: #'inappropriate operation' ifAbsent: 6.
	PrimErrUnsupported		:= pet indexOf: #'unsupported operation' ifAbsent: 7.
	PrimErrNoModification		:= pet indexOf: #'no modification' ifAbsent: 8.
	PrimErrNoMemory			:= pet indexOf: #'insufficient object memory' ifAbsent: 9.
	PrimErrNoCMemory			:= pet indexOf: #'insufficient C memory' ifAbsent: 10.
	PrimErrNotFound			:= pet indexOf: #'not found' ifAbsent: 11.
	PrimErrBadMethod			:= pet indexOf: #'bad method' ifAbsent: 12.
	PrimErrNamedInternal		:= pet indexOf: #'internal error in named primitive machinery' ifAbsent: 13.
	PrimErrObjectMayMove		:= pet indexOf: #'object may move' ifAbsent: 14.
	PrimErrLimitExceeded		:= pet indexOf: #'resource limit exceeded' ifAbsent: 15.
	PrimErrObjectIsPinned		:= pet indexOf: #'object is pinned' ifAbsent: 16.
	PrimErrWritePastObject	:= pet indexOf: #'primitive write beyond end of object' ifAbsent: 17