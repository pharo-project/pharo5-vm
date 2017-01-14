primitive support
unpinObject: objOop
	"For forward-compatibility with Spur.  Fail; ObjectMemory does not support pinning."
	<api>
	coInterpreter primitiveFailFor: PrimErrUnsupported