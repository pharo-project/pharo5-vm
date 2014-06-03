utility
asCString: stringOop
	"Return a C char * pointer into the given Squeak string object."
	"Warning: A Squeak string is not necessarily null-terminated."
	"Warning: the resulting pointer may become invalid after the next garbage collection and should only be using during the current primitive call."

	<returnTypeC: #'char *'>

	interpreterProxy success: (interpreterProxy isBytes: stringOop).

	^interpreterProxy failed
		ifTrue: [0]
		ifFalse: [self cCoerce: (interpreterProxy firstIndexableField: stringOop) to: #'char *']