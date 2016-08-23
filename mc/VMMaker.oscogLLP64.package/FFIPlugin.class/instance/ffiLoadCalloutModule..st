symbol loading
ffiLoadCalloutModule: module
	"Load the given module and return its handle"
	| moduleHandlePtr moduleHandle ffiModuleName moduleLength rcvr theClass ptr |
	<var: #ptr type:'int *'>
	(interpreterProxy isBytes: module) ifTrue:[
		"plain module name"
		ffiModuleName := module.
		moduleLength := interpreterProxy byteSizeOf: ffiModuleName.
		moduleHandle := interpreterProxy ioLoadModule: (self cCoerce: (interpreterProxy firstIndexableField: ffiModuleName) to:'int') OfLength: moduleLength.
		interpreterProxy failed ifTrue:[^self ffiFail: FFIErrorModuleNotFound]. "failed"
		^moduleHandle].
	"Check if the external method is defined in an external library"
	rcvr := interpreterProxy stackValue: interpreterProxy methodArgumentCount.
	theClass := interpreterProxy fetchClassOf: rcvr.
	(interpreterProxy includesBehavior: theClass 
			ThatOf: interpreterProxy classExternalLibrary) ifFalse:[^0].
	"external library"
	moduleHandlePtr := interpreterProxy fetchPointer: 0 ofObject: rcvr.
	moduleHandle := self ffiContentsOfHandle: moduleHandlePtr errCode: FFIErrorBadExternalLibrary.
	interpreterProxy failed ifTrue:[^0].
	moduleHandle = 0 ifTrue:["need to reload module"
		ffiModuleName := interpreterProxy fetchPointer: 1 ofObject: rcvr.
		(interpreterProxy isBytes: ffiModuleName) ifFalse:[^self ffiFail: FFIErrorBadExternalLibrary].
		moduleLength := interpreterProxy byteSizeOf: ffiModuleName.
		moduleHandle := interpreterProxy ioLoadModule: (self cCoerce: (interpreterProxy firstIndexableField: ffiModuleName) to:'int') OfLength: moduleLength.
		interpreterProxy failed ifTrue:[^self ffiFail: FFIErrorModuleNotFound]. "failed"
		"and store back"
		ptr := interpreterProxy firstIndexableField: moduleHandlePtr.
		ptr at: 0 put: moduleHandle].
	^moduleHandle