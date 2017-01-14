C code generation
emitCFunctionPrototype: aStream generator: aCodeGen
	"Emit a C function header for this method onto the given stream."

	properties ifNotNil:
		[(properties at: #api: ifAbsent: []) ifNotNil:
			[:pragma|
			aStream
				nextPutAll: (pragma argumentAt: 1);
				nextPut: $;;
				cr.
			^self]].
	self emitCFunctionPrototype: aStream generator: aCodeGen isPrototype: true