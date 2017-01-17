primitives
primitiveForceLoad
	"Primitive. Force loading the receiver (an instance of ExternalLibrary)."
	| rcvr moduleHandlePtr moduleHandle ffiModuleName ptr |
	<export: true>
	<inline: false>
	<var: #ptr type: #'sqInt *'>
	interpreterProxy methodArgumentCount = 0 ifFalse:
		[^interpreterProxy primitiveFail].
	rcvr := interpreterProxy stackValue: 0.
	(interpreterProxy is: rcvr KindOfClass: interpreterProxy classExternalLibrary) ifFalse:
		[^self ffiFail: FFIErrorBadExternalLibrary].
	moduleHandlePtr := interpreterProxy fetchPointer: 0 ofObject: rcvr.
	moduleHandle := self ffiContentsOfHandle: moduleHandlePtr errCode: FFIErrorBadExternalLibrary.
	interpreterProxy failed ifTrue:
		[^0].
	ffiModuleName := interpreterProxy fetchPointer: 1 ofObject: rcvr.
	(interpreterProxy isBytes: ffiModuleName) ifFalse:
		[^self ffiFail: FFIErrorBadExternalLibrary].
	moduleHandle := (interpreterProxy
						ioLoadModule: (interpreterProxy firstIndexableField: ffiModuleName) asInteger
						OfLength: (interpreterProxy byteSizeOf: ffiModuleName)) asInteger.
	interpreterProxy failed ifTrue:
		[^self ffiFail: FFIErrorModuleNotFound]. "failed"
	"and store back"
	ptr := interpreterProxy firstIndexableField: moduleHandlePtr.
	ptr at: 0 put: moduleHandle.
	^0 "done"