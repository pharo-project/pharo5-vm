utility
copyString: stringOop into: stringPtr max: maxChars
	"Copy the Squeak string into a temporary buffer and add a terminating null byte. Fail if there is not sufficent space in the buffer."

	| srcPtr count |
	<inline: false>
	<var: 'stringPtr' type: #'char *'>
	<var: 'srcPtr' type: #'char *'>

	((interpreterProxy isBytes: stringOop)
	and: [(count := interpreterProxy stSizeOf: stringOop) < maxChars]) ifFalse:
		[interpreterProxy success: false.
		^ 0].

	srcPtr := self cCoerce: (interpreterProxy firstIndexableField: stringOop) to: #'char *'.
	1 to: count do: [:i | self cCode: '*stringPtr++ = *srcPtr++'].
	self cCode: '*stringPtr = 0'.
	^ 0