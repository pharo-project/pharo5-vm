callout support
ffiPushStructureContentsOf: oop
	"Push the contents of the given external structure"
	| ptrValue ptrClass ptrAddress |
	<inline: true>
	ptrValue := oop.
	ptrClass := interpreterProxy fetchClassOf: ptrValue.
	ptrClass == interpreterProxy classExternalAddress ifTrue:[
		ptrAddress := interpreterProxy fetchPointer: 0 ofObject: ptrValue.
		"There is no way we can make sure the structure is valid.
		But we can at least check for attempts to pass pointers to ST memory."
		(interpreterProxy isInMemory: ptrAddress)
			ifTrue:[^self ffiFail: FFIErrorInvalidPointer].
		^self ffiPush: ptrAddress 
				Structure: (self cCoerce: ffiArgSpec to:'int*')
				OfLength: ffiArgSpecSize].
	ptrClass == interpreterProxy classByteArray ifTrue:[
		"The following is a somewhat pessimistic test but I like being sure..."
		(interpreterProxy byteSizeOf: ptrValue) = (ffiArgHeader bitAnd: FFIStructSizeMask)
			ifFalse:[^self ffiFail: FFIErrorStructSize].
		ptrAddress := self cCoerce: (interpreterProxy firstIndexableField: ptrValue) to: 'int'.
		(ffiArgHeader anyMask: FFIFlagPointer) ifFalse:[
			^self ffiPush: ptrAddress 
					Structure: (self cCoerce: ffiArgSpec to: 'int*')
					OfLength: ffiArgSpecSize].
		"If FFIFlagPointer + FFIFlagStructure is set use ffiPushPointer on the contents"
		(ffiArgHeader bitAnd: FFIStructSizeMask) = 4
			ifFalse:[^self ffiFail: FFIErrorStructSize].
		ptrAddress := interpreterProxy fetchPointer: 0 ofObject: ptrValue.
		(interpreterProxy isInMemory: ptrAddress)
			ifTrue:[^self ffiFail: FFIErrorInvalidPointer].
		^self ffiPushPointer: ptrAddress].
	^self ffiFail: FFIErrorBadArg