callout support
ffiCall: externalFunction ArgArrayOrNil: argArrayOrNil NumArgs: nArgs
	"Generic callout. Does the actual work.  If argArrayOrNil is nil it takes args from the stack
	 and the spec from the method.  If argArrayOrNil is not nil takes args from argArrayOrNil
	 and the spec from the receiver."
	| flags argTypeArray address argType oop argSpec argClass err theCalloutState calloutState requiredStackSize stackSize allocation result |
	<inline: true>
	<var: #theCalloutState type: #'CalloutState'>
	<var: #calloutState type: #'CalloutState *'>
	<var: #allocation type: #'char *'>

	(interpreterProxy is: externalFunction KindOfClass: interpreterProxy classExternalFunction) ifFalse:
		[^self ffiFail: FFIErrorNotFunction].
	"Load and check the values in the externalFunction before we call out"
	flags := interpreterProxy fetchInteger: ExternalFunctionFlagsIndex ofObject: externalFunction.
	interpreterProxy failed ifTrue:
		[^self ffiFail: FFIErrorBadArgs].

	"This must come early for compatibility with the old FFIPlugin.  Image-level code
	 may assume the function pointer is loaded eagerly.  Thanks to Nicolas Cellier."
	address := self ffiLoadCalloutAddress: externalFunction.
	interpreterProxy failed ifTrue:
		[^0 "error code already set by ffiLoadCalloutAddress:"].
	
	argTypeArray := interpreterProxy fetchPointer: ExternalFunctionArgTypesIndex ofObject: externalFunction.
	"must be array of arg types"
	((interpreterProxy isArray: argTypeArray)
	and: [(interpreterProxy slotSizeOf: argTypeArray) = (nArgs + 1)]) ifFalse:
		[^self ffiFail: FFIErrorBadArgs].
	"check if the calling convention is supported"
	self cppIf: COGMTVM
		ifTrue:
			[(self ffiSupportsCallingConvention: (flags bitAnd: FFICallTypesMask)) ifFalse:
				[^self ffiFail: FFIErrorCallType]]
		ifFalse: "not masking causes threaded calls to fail, which is as they should if the plugin is not threaded."
			[(self ffiSupportsCallingConvention: flags) ifFalse:
				[^self ffiFail: FFIErrorCallType]].
		
	requiredStackSize := self externalFunctionHasStackSizeSlot
							ifTrue: [interpreterProxy
										fetchInteger: ExternalFunctionStackSizeIndex
										ofObject: externalFunction]
							ifFalse: [-1].
	interpreterProxy failed ifTrue:
		[^interpreterProxy primitiveFailFor: (argArrayOrNil isNil
												ifTrue: [PrimErrBadMethod]
												ifFalse: [PrimErrBadReceiver])].
	stackSize := requiredStackSize < 0 ifTrue: [DefaultMaxStackSize] ifFalse: [requiredStackSize].
	self cCode: [] inSmalltalk: [theCalloutState := self class calloutStateClass new].
	calloutState := self addressOf: theCalloutState.
	self cCode: [self me: calloutState ms: 0 et: (self sizeof: #CalloutState)].
	calloutState callFlags: flags.
	"Fetch return type and args"
	argType := interpreterProxy fetchPointer: 0 ofObject: argTypeArray.
	argSpec := interpreterProxy fetchPointer: 0 ofObject: argType.
	argClass := interpreterProxy fetchPointer: 1 ofObject: argType.
	(err := self ffiCheckReturn: argSpec With: argClass in: calloutState) ~= 0 ifTrue:
		[^self ffiFail: err]. "cannot return"
	"alloca the outgoing stack frame, leaving room for register args while marshalling, and including space for the return struct, if any."
	allocation := self alloca: stackSize + calloutState structReturnSize + self registerArgsSlop + self cStackAlignment.
	self allocaLiesSoUseGetsp ifTrue:
		[allocation := self getsp].
	self cStackAlignment ~= 0 ifTrue:
		[allocation := self cCoerce: (allocation asUnsignedInteger bitClear: self cStackAlignment - 1)
						to: #'char *'].
	calloutState
		argVector: allocation;
		currentArg: allocation + self registerArgsSlop;
		limit: allocation + stackSize + self registerArgsSlop.
	(calloutState structReturnSize > 0
	 and: [self nonRegisterStructReturnIsViaImplicitFirstArgument
	 and: [(self returnStructInRegisters: calloutState structReturnSize) not]]) ifTrue:
		[err := self ffiPushPointer: calloutState limit in: calloutState.
		 err ~= 0 ifTrue:
			[self cleanupCalloutState: calloutState.
			 self cppIf: COGMTVM ifTrue:
			 [err = PrimErrObjectMayMove negated ifTrue:
				[^PrimErrObjectMayMove]]. "N.B. Do not fail if object may move because caller will GC and retry."
			 ^self ffiFail: err]].
	1 to: nArgs do:
		[:i|
		argType := interpreterProxy fetchPointer: i ofObject: argTypeArray.
		argSpec := interpreterProxy fetchPointer: 0 ofObject: argType.
		argClass := interpreterProxy fetchPointer: 1 ofObject: argType.
		oop := argArrayOrNil isNil
				ifTrue: [interpreterProxy stackValue: nArgs - i]
				ifFalse: [interpreterProxy fetchPointer: i - 1 ofObject: argArrayOrNil].
		err := self ffiArgument: oop Spec: argSpec Class: argClass in: calloutState.
		err ~= 0 ifTrue:
			[self cleanupCalloutState: calloutState.
			 self cppIf: COGMTVM ifTrue:
			 [err = PrimErrObjectMayMove negated ifTrue:
				[^PrimErrObjectMayMove]]. "N.B. Do not fail if object may move because caller will GC and retry."
			 ^self ffiFail: err]]. "coercion failed or out of stack space"
	"Failures must be reported back from ffiArgument:Spec:Class:in:.
	 Should not fail from here on in."
	self assert: interpreterProxy failed not.
	self ffiLogCallout: externalFunction.
	(requiredStackSize < 0
	 and: [self externalFunctionHasStackSizeSlot]) ifTrue:
		[stackSize := calloutState currentArg - calloutState argVector.
		 interpreterProxy storeInteger: ExternalFunctionStackSizeIndex ofObject: externalFunction withValue: stackSize].
	"Go out and call this guy"
	result := self ffiCalloutTo: address SpecOnStack: argArrayOrNil notNil in: calloutState.
	self cleanupCalloutState: calloutState.
	^result