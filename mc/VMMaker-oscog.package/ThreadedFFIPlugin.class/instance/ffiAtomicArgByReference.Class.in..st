callout support
ffiAtomicArgByReference: oop Class: oopClass in: calloutState
	<var: #calloutState type: #'CalloutState *'>
	"Support for generic callout. Prepare a pointer reference to an atomic type for callout.
	 Note: for type 'void*' we allow ByteArray/String/Symbol, wordVariableSubclass or Alien."
	| atomicType isString isAlien |
	<inline: true>
	atomicType := self atomicTypeOf: calloutState ffiArgHeader.
	(atomicType = FFITypeBool) ifTrue: "No bools on input"
		[^FFIErrorCoercionFailed].
	isAlien := (isString := interpreterProxy 
					includesBehavior: oopClass 
					ThatOf: interpreterProxy classString)
				ifTrue: [false]
				ifFalse:
					[interpreterProxy 
						includesBehavior: oopClass 
						ThatOf: interpreterProxy classAlien].
	((atomicType >> 1) = (FFITypeSignedChar >> 1)) ifTrue:"string value (char*)"
		"note: the only types allowed for passing into char* types are
		ByteArray, String, Symbol, Alien and *no* other byte indexed objects
		(e.g., CompiledMethod, LargeInteger). We only check for strings
		here and fall through to the byte* check otherwise."
		[isString ifTrue:"String/Symbol"
			"Strings must be allocated by the ffi support code"
			[^self ffiPushString: (interpreterProxy firstIndexableField: oop)
				OfLength: (interpreterProxy byteSizeOf: oop)
				in: calloutState].
		"Fall through to byte* test"
		atomicType := FFITypeUnsignedByte].

	self cppIf: COGMTVM ifTrue:
	["Since all the following pass the address of the first indexable field we need to fail
	 the call if it is threaded and the object is young, since it may move during the call."
	((calloutState callFlags anyMask: FFICallFlagThreaded)
	and: [(isAlien not or: [self isDirectAlien: oop])
	and: [interpreterProxy isYoung: oop]]) ifTrue:
		[^PrimErrObjectMayMove negated]].

	(atomicType = FFITypeVoid or:[(atomicType >> 1) = (FFITypeSignedByte >> 1)]) ifTrue:
		"byte* -- see comment on string above"
		[(isString
		  or: [oopClass = interpreterProxy classByteArray]) ifTrue:"String/Symbol/ByteArray"
			[^self ffiPushPointer: (interpreterProxy firstIndexableField: oop) in: calloutState].
		isAlien ifTrue:
			[^self ffiPushPointer: (self pointerForOop: (self startOfData: oop)) in: calloutState].
		atomicType = FFITypeVoid ifFalse:
			[^FFIErrorCoercionFailed]].
		"note: type void falls through"

	(atomicType <= FFITypeSignedInt "void/short/int"
	or:[atomicType = FFITypeSingleFloat]) ifTrue:
		["require a word subclass to work"
		(interpreterProxy isWords: oop) ifTrue:
			[^self ffiPushPointer: (interpreterProxy firstIndexableField: oop) in: calloutState]].

	^FFIErrorCoercionFailed