util
pointerToFirstDigitOfLargeInt: bytesObject
	<inline: true>
	<returnTypeC: #'unsigned int *'>
	^interpreterProxy cCoerce: (interpreterProxy firstIndexableField: bytesObject) to: #'unsigned int *'