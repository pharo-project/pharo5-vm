callout support
ffiPushPointerContentsOf: oop
	"Push the contents of the given external structure"
	| ptrValue ptrClass ptrAddress |
	<inline: false>
	ptrValue := oop.
	ptrClass := interpreterProxy fetchClassOf: ptrValue.
	ptrClass == interpreterProxy classExternalAddress ifTrue:[
		ptrAddress := interpreterProxy fetchPointer: 0 ofObject: ptrValue.
		"Don't you dare to pass pointers into object memory"
		(interpreterProxy isInMemory: ptrAddress)
			ifTrue:[^self ffiFail: FFIErrorInvalidPointer].
		^self ffiPushPointer: ptrAddress].
	ptrClass == interpreterProxy classByteArray ifTrue:[
		ptrAddress := self cCoerce: (interpreterProxy firstIndexableField: ptrValue) to: 'int'.
		^self ffiPushPointer: ptrAddress].
	^self ffiFail: FFIErrorBadArg