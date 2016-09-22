file primitives
cfileValueOf: objectPointer
	"Return a pointer to the first byte of of the file record within the given Smalltalk object, or nil if objectPointer is not a cfile record."
	<returnTypeC: 'FILE *'>
	<static: false>
	(((interpreterProxy isBytes: objectPointer) and:
		 [(interpreterProxy byteSizeOf: objectPointer) = self cfileRecordSize]))
			ifFalse:[interpreterProxy primitiveFail. ^nil].
	^interpreterProxy firstIndexableField: objectPointer