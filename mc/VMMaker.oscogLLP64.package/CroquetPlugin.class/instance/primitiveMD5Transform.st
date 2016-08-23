cryptography
primitiveMD5Transform
	"Perform an MD5 transform of input"
	| bufOop hashOop hash buffer |
	<export: true>
	<var: 'hash' type: 'unsigned int *'>
	<var: 'buffer' type: 'unsigned int *'>
	interpreterProxy methodArgumentCount = 2 
		ifFalse:[^interpreterProxy primitiveFail].

	hashOop := interpreterProxy stackObjectValue: 0.
	((interpreterProxy isWords: hashOop) and:[(interpreterProxy slotSizeOf: hashOop) = 4])
		ifFalse:[^interpreterProxy primitiveFail].
	hash := interpreterProxy firstIndexableField: hashOop.

	bufOop := interpreterProxy stackObjectValue: 1.
	((interpreterProxy isWords: bufOop) and:[(interpreterProxy slotSizeOf: bufOop) = 16])
		ifFalse:[^interpreterProxy primitiveFail].
	buffer := interpreterProxy firstIndexableField: bufOop.


	self cCode:'MD5Transform(hash, buffer)' inSmalltalk:[
		hash. buffer. 
		^interpreterProxy primitiveFail].
	"Pop args; return buffer"
	interpreterProxy pop: interpreterProxy methodArgumentCount+1.
	^interpreterProxy push: bufOop.