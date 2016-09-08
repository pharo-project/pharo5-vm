object format
fixedFieldsOf: oop format: fmt length: wordLength
"
	NOTE: This code supports the backward-compatible extension to 8 bits of instSize.
	When we revise the image format, it should become...
	^ (classFormat >> 2 bitAnd: 16rFF) - 1
"
	| class classFormat |
	<inline: true>
	((fmt > self lastPointerFormat) or: [fmt = self arrayFormat]) ifTrue: [^0].  "indexable fields only"
	fmt < 2 ifTrue: [^wordLength].  "fixed fields only (zero or more)"
	
	"fmt = 3 or 4: mixture of fixed and indexable fields, so must look at class format word"
	class := self fetchClassOfNonImm: oop.
	classFormat := self formatOfClass: class.
	^(classFormat >> 11 bitAnd: 16rC0) + (classFormat >> 2 bitAnd: 16r3F) - 1