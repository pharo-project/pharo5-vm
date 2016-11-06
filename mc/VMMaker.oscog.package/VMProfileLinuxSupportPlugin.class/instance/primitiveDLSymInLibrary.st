primitives
primitiveDLSymInLibrary
	"Answer the address of the symbol whose name is the first argument
	 in the library whose name is the second argument, or nil if none."
	| nameObj symName libName lib sz addr ok |
	<export: true>
	<var: #symName type: #'char *'>
	<var: #libName type: #'char *'>
	<var: #lib type: #'void *'>
	<var: #addr type: #'void *'>
	nameObj := interpreterProxy stackValue: 0.
	(interpreterProxy isBytes: nameObj) ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	sz := interpreterProxy byteSizeOf: nameObj.
	libName := self malloc: sz+1.
	self st: libName rn: (interpreterProxy firstIndexableField: nameObj) cpy: sz.
	libName at: sz put: 0.
	nameObj := interpreterProxy stackValue: 1.
	(interpreterProxy isBytes: nameObj) ifFalse:
		[self free: libName.
		 ^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	sz := interpreterProxy byteSizeOf: nameObj.
	symName := self malloc: sz+1.
	self st: symName rn: (interpreterProxy firstIndexableField: nameObj) cpy: sz.
	symName at: sz put: 0.
	lib := self dl: libName open: (#'RTLD_LAZY' bitOr: #'RTLD_NODELETE').
	lib ifNil:
		[self free: libName; free: symName.
		 ^interpreterProxy primitiveFailFor: PrimErrInappropriate].
	self dlerror. "clear dlerror"
	addr := self dl: lib sym: symName.
	ok := self dlerror isNil.
	self free: symName.
	self free: libName.
	self dlclose: lib.
	ok ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrNotFound].
	^interpreterProxy methodReturnValue: (interpreterProxy positiveMachineIntegerFor: addr asUnsignedIntegerPtr)