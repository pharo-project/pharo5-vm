marshalling
ffiPushPointerContentsOf: oop in: calloutState
	<var: #calloutState type: #'CalloutState *'>
	"Push the contents of the given external structure"
	| ptrClass ptrAddress |
	<inline: false>
	ptrClass := interpreterProxy fetchClassOf: oop.
	ptrClass = interpreterProxy classExternalAddress ifTrue:
		[ptrAddress := (interpreterProxy fetchPointer: 0 ofObject: oop) asVoidPointer.
		"Don't you dare to pass pointers into object memory"
		(interpreterProxy isInMemory: ptrAddress) ifTrue:
			[^FFIErrorInvalidPointer].
		^self ffiPushPointer: ptrAddress in: calloutState].

	ptrClass = interpreterProxy classByteArray ifTrue:
		["Since this involves passing the address of the first indexable field we need to fail
		  the call if it is threaded and the object is young, since it may move during the call."
		 self cppIf: COGMTVM ifTrue:
		 [((calloutState callFlags anyMask: FFICallFlagThreaded)
		   and: [interpreterProxy isYoung: oop]) ifTrue:
			[^PrimErrObjectMayMove negated]].

		ptrAddress := interpreterProxy firstIndexableField: oop.
		^self ffiPushPointer: ptrAddress in: calloutState].

	(interpreterProxy includesBehavior: ptrClass ThatOf: interpreterProxy classAlien) ifTrue:
		[self cppIf: COGMTVM ifTrue:
		 [((calloutState callFlags anyMask: FFICallFlagThreaded)
		   and: [(self isDirectAlien: oop)
		   and: [interpreterProxy isYoung: oop]]) ifTrue:
			[^PrimErrObjectMayMove negated]].

		ptrAddress := self startOfData: oop.
		^self ffiPushPointer: ptrAddress in: calloutState].

	^FFIErrorBadArg