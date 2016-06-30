callout support
ffiArgument: oop Spec: argSpec Class: argClass in: calloutState
	"Callout support. Prepare the given oop as argument.
	argSpec defines the compiled spec for the argument.
	argClass (if non-nil) defines the required (super)class for the argument."
	<var: #calloutState type: #'CalloutState *'>
	| valueOop oopClass isStruct nilOop |
	<inline: false>
	oopClass := interpreterProxy fetchClassOf: oop. "Prefetch class (we'll need it)"
	nilOop :=  interpreterProxy nilObject.
	"Do the necessary type checks"
	argClass = nilOop ifFalse:[
		"Type check 1: 
		Is the required class of the argument a subclass of ExternalStructure?"
		(interpreterProxy includesBehavior: argClass 
						ThatOf: interpreterProxy classExternalStructure)
			ifFalse:[^FFIErrorWrongType]. "Nope. Fail."
		"Type check 2:
		Is the class of the argument a subclass of required class?"
		((nilOop = oop) or:[interpreterProxy includesBehavior: oopClass ThatOf: argClass])
				ifFalse:[^FFIErrorCoercionFailed]. "Nope. Fail."
		"Okay, we've passed the type check (so far)"
	].

	"Check if oopClass is a subclass of ExternalStructure.
	If this is the case we'll work on it's handle and not the actual oop."
	isStruct := false.
	(oop ~= nilOop
	 and: [interpreterProxy isPointers: oop]) ifTrue: "#isPointers: will fail if oop is immediate so don't even attempt to use it"
		[isStruct := interpreterProxy
						includesBehavior: oopClass 
						ThatOf: interpreterProxy classExternalStructure.
		 (argClass = nilOop or: [isStruct]) ifFalse:
			[^FFIErrorCoercionFailed]].
	"note: the test for #isPointers: above should speed up execution since no pointer type
	 ST objects are allowed in external calls and thus if #isPointers: is true then the arg must
	 be ExternalStructure to work. If it isn't then the code fails anyways so speed isn't an issue."

	"Determine valueOop (e.g., the actual oop to pass as argument)"
	isStruct
		ifTrue:[valueOop := interpreterProxy fetchPointer: 0 ofObject: oop]
		ifFalse:[valueOop := oop].

	"Fetch and check the contents of the compiled spec"
	(interpreterProxy isWords: argSpec)
		ifFalse:[^FFIErrorWrongType].
	calloutState ffiArgSpecSize: (interpreterProxy slotSizeOf: argSpec).
	calloutState ffiArgSpecSize = 0 ifTrue:[^FFIErrorWrongType].
	calloutState ffiArgSpec: (interpreterProxy firstIndexableField: argSpec).
	calloutState ffiArgHeader: (interpreterProxy longAt: calloutState ffiArgSpec).

	"Do the actual preparation of the argument"
	"Note: Order is important since FFIFlagStructure + FFIFlagPointer is used to represent 'typedef void* VoidPointer' and VoidPointer really is *struct* not pointer."

	(calloutState ffiArgHeader anyMask: FFIFlagStructure) ifTrue:[
		"argument must be ExternalStructure"
		isStruct ifFalse:[^FFIErrorCoercionFailed].
		(calloutState ffiArgHeader anyMask: FFIFlagAtomic) 
			ifTrue:[^FFIErrorWrongType]. "bad combination"
		^self ffiPushStructureContentsOf: valueOop in: calloutState].

	(calloutState ffiArgHeader anyMask: FFIFlagPointer) ifTrue:[
		"no integers (or characters) for pointers please"
		(interpreterProxy isImmediate: oop) 
			ifTrue:[^FFIErrorIntAsPointer].

		"but allow passing nil pointer for any pointer type"
		oop = nilOop ifTrue:[^self ffiPushPointer: nil in: calloutState].

		"argument is reference to either atomic or structure type"
		(calloutState ffiArgHeader anyMask: FFIFlagAtomic) ifTrue:[
			isStruct "e.g., ExternalData"
				ifTrue:[^self ffiAtomicStructByReference: oop Class: oopClass in: calloutState]
				ifFalse:[^self ffiAtomicArgByReference: oop Class: oopClass in: calloutState].
			"********* NOTE: The above uses 'oop' not 'valueOop' (for ExternalData) ******"
		].

		"Needs to be external structure here"
		isStruct ifFalse:[^FFIErrorCoercionFailed].
		^self ffiPushPointerContentsOf: valueOop in: calloutState].

	(calloutState ffiArgHeader anyMask: FFIFlagAtomic) ifTrue:[
		"argument is atomic value"
		^self ffiArgByValue: valueOop in: calloutState].
	"None of the above - bad spec"
	^FFIErrorWrongType