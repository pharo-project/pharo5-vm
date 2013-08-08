callout support
ffiAtomicArgByReference: oop Class: oopClass
	"Support for generic callout. Prepare a pointer reference to an atomic type for callout. Note: for type 'void*' we allow either one of ByteArray/String/Symbol or wordVariableSubclass."
	| atomicType isString |
	<inline: true>
	atomicType := self atomicTypeOf: ffiArgHeader.
	(atomicType = FFITypeBool) "No bools on input"
		ifTrue:[^self ffiFail: FFIErrorCoercionFailed].
	((atomicType >> 1) = (FFITypeSignedChar >> 1)) ifTrue:["string value (char*)"
		"note: the only types allowed for passing into char* types are
		ByteArray, String, Symbol and *no* other byte indexed objects
		(e.g., CompiledMethod, LargeInteger). We only check for strings
		here and fall through to the byte* check otherwise."
		isString := interpreterProxy 
					includesBehavior: oopClass 
					ThatOf: interpreterProxy classString.
		isString ifTrue:["String/Symbol"
			"Strings must be allocated by the ffi support code"
			^self ffiPushString: (self cCoerce: (interpreterProxy firstIndexableField: oop) to: 'int') OfLength: (interpreterProxy byteSizeOf: oop)].
		"Fall through to byte* test"
		atomicType := FFITypeUnsignedByte].

	(atomicType = FFITypeVoid or:[(atomicType >> 1) = (FFITypeSignedByte >> 1)]) ifTrue:[
		"byte* -- see comment on string above"
		oopClass = interpreterProxy classByteArray ifTrue:["ByteArray"
			^self ffiPushPointer: (self cCoerce: (interpreterProxy firstIndexableField: oop) to:'int')].
		isString := interpreterProxy includesBehavior: oopClass 
					ThatOf: interpreterProxy classString.
		isString ifTrue:["String/Symbol"
			^self ffiPushPointer: (self cCoerce: (interpreterProxy firstIndexableField: oop) to:'int')].
		atomicType = FFITypeVoid ifFalse:[^self ffiFail: FFIErrorCoercionFailed].
		"note: type void falls through"
	].

	(atomicType <= FFITypeSignedInt "void/short/int"
		or:[atomicType = FFITypeSingleFloat]) ifTrue:[
			"require a word subclass to work"
			(interpreterProxy isWords: oop) ifTrue:[
				^self ffiPushPointer: (self cCoerce: (interpreterProxy firstIndexableField: oop) to:'int')]].

	^self ffiFail: FFIErrorCoercionFailed.