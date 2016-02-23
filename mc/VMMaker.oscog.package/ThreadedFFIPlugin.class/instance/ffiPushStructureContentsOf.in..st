callout support
ffiPushStructureContentsOf: oop in: calloutState
	<var: #calloutState type: #'CalloutState *'>
	"Push the contents of the given external structure"
	| ptrClass ptrAddress |
	<inline: true>
	ptrClass := interpreterProxy fetchClassOf: oop.
	ptrClass = interpreterProxy classExternalAddress ifTrue: "ExternalAddress is bytes"
		[ptrAddress := (interpreterProxy fetchPointer: 0 ofObject: oop) asVoidPointer.
		"There is no way we can make sure the structure is valid.
		But we can at least check for attempts to pass pointers to ST memory."
		(interpreterProxy isInMemory: ptrAddress) ifTrue:
			[^FFIErrorInvalidPointer].
		^self ffiPushStructure: ptrAddress
			ofSize: (calloutState ffiArgHeader bitAnd: FFIStructSizeMask)
			typeSpec: calloutState ffiArgSpec
			ofLength: calloutState ffiArgSpecSize
			in: calloutState].
	ptrClass = interpreterProxy classByteArray ifTrue:
		["The following is a somewhat pessimistic test but I like being sure..."
		(interpreterProxy byteSizeOf: oop) = (calloutState ffiArgHeader bitAnd: FFIStructSizeMask)
			ifFalse:[^FFIErrorStructSize].
		ptrAddress := interpreterProxy firstIndexableField: oop.
		(calloutState ffiArgHeader anyMask: FFIFlagPointer) ifFalse:
			"Since this involves passing the address of the first indexable field we need to fail
			  the call if it is threaded and the object is young, since it may move during the call."
			[self cppIf: COGMTVM ifTrue:
			 [((calloutState callFlags anyMask: FFICallFlagThreaded)
			 and: [interpreterProxy isYoung: oop]) ifTrue:
				[^PrimErrObjectMayMove negated]].
			^self ffiPushStructure: ptrAddress
				ofSize: (calloutState ffiArgHeader bitAnd: FFIStructSizeMask)
				typeSpec: calloutState ffiArgSpec
				ofLength: calloutState ffiArgSpecSize
				in: calloutState].
		"If FFIFlagPointer + FFIFlagStructure is set use ffiPushPointer on the contents"
		(calloutState ffiArgHeader bitAnd: FFIStructSizeMask) = 4 ifFalse:
			[^FFIErrorStructSize].
		ptrAddress := (interpreterProxy fetchPointer: 0 ofObject: oop) asVoidPointer.
		(interpreterProxy isInMemory: ptrAddress) ifTrue:
			[^FFIErrorInvalidPointer].
		^self ffiPushPointer: ptrAddress in: calloutState].
	^FFIErrorBadArg