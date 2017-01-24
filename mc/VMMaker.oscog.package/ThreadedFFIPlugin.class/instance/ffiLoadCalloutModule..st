symbol loading
ffiLoadCalloutModule: module
	"Load the given module and return its handle"
	| moduleHandlePtr moduleHandle ffiModuleName moduleLength rcvr ptr |
	<var: #ptr type:'sqInt *'>
	(interpreterProxy isBytes: module) ifTrue:[
		"plain module name"
		ffiModuleName := module.
		moduleLength := interpreterProxy byteSizeOf: ffiModuleName.
		moduleHandle := (interpreterProxy
							ioLoadModule: (interpreterProxy firstIndexableField: ffiModuleName) asInteger
							OfLength: moduleLength) asInteger.
		(interpreterProxy failed
		 or: [moduleHandle = 0]) ifTrue:
			[^self ffiFail: FFIErrorModuleNotFound]. "failed"
		^moduleHandle].
	"Check if the external method is defined in an external library"
	rcvr := interpreterProxy stackValue: interpreterProxy methodArgumentCount.
	(interpreterProxy is: rcvr KindOfClass: interpreterProxy classExternalLibrary) ifFalse:
		[^self ffiFail: FFIErrorNoModule].
	"external library"
	moduleHandlePtr := interpreterProxy fetchPointer: 0 ofObject: rcvr.
	moduleHandle := self ffiContentsOfHandle: moduleHandlePtr errCode: FFIErrorBadExternalLibrary.
	interpreterProxy failed ifTrue:[^0].
	moduleHandle = 0 ifTrue:["need to reload module"
		ffiModuleName := interpreterProxy fetchPointer: 1 ofObject: rcvr.
		(interpreterProxy isBytes: ffiModuleName) ifFalse:[^self ffiFail: FFIErrorBadExternalLibrary].
		moduleLength := interpreterProxy byteSizeOf: ffiModuleName.
		moduleHandle := (interpreterProxy
								ioLoadModule: (interpreterProxy firstIndexableField: ffiModuleName) asInteger
								OfLength: moduleLength) asInteger.
		(interpreterProxy failed
		 or: [moduleHandle = 0]) ifTrue:
			[^self ffiFail: FFIErrorModuleNotFound]. "failed"
		"and store back"
		ptr := interpreterProxy firstIndexableField: moduleHandlePtr.
		ptr at: 0 put: moduleHandle].
	^moduleHandle