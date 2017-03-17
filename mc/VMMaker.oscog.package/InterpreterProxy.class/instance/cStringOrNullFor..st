testing
cStringOrNullFor: oop
	"Answer either a malloced string with the null-terminated contents of oop if oop is a string,
	 or the null pointer if oop is nil, or fail.  It is the client's responsibility to free the string later."
	<returnTypeC: #'char *'>
	oop isString ifTrue: [^oop] ifFalse: [self primitiveFail. ^0]