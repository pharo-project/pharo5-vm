primitives
primitiveDLSym
	"Answer the address of the argument in the current process or nil if none."
	| nameObj name namePtr sz addr |
	<export: true>
	<var: #name type: #'char *'>
	<var: #namePtr type: #'char *'>
	<var: #addr type: #'void *'>
	nameObj := interpreterProxy stackValue: 0.
	(interpreterProxy isBytes: nameObj) ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	sz := interpreterProxy byteSizeOf: nameObj.
	name := self malloc: sz+1.
	namePtr := interpreterProxy firstIndexableField: nameObj.
	0 to: sz-1 do:[:i| name at: i put: (namePtr at: i)].
	name at: sz put: 0.
	addr := self cCode: 'dlsym(RTLD_SELF,name)' inSmalltalk: [0].
	self free: name.
	^interpreterProxy methodReturnValue: (addr = 0
												ifTrue: [interpreterProxy nilObject]
												ifFalse: [interpreterProxy positiveMachineIntegerFor: addr asUnsignedIntegerPtr])