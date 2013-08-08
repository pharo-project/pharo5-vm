initialize
primitiveNewFaceFromFile: fontFilePath index: anInteger  
	"Fill in the receiver's (a FT2Face object) fields
	from the address and fields of a newly opened FT_Face object."

	| rcvr face byteSize translatedFilePath |
	rcvr := self primitive: 'primitiveNewFaceFromFileAndIndex'
		parameters: #(String SmallInteger)
		receiver: #FT2Face.
	self touch: rcvr.

	self var: #face type: 'FT_Face'.	"a pointer"
	self var: #byteSize type: 'size_t'.
	self var: #translatedFilePath declareC: 'char translatedFilePath[1024]'.
	
	errorCode := 0.

	byteSize := interpreterProxy byteSizeOf: fontFilePath cPtrAsOop.
	self touch: byteSize.
	interpreterProxy failed ifTrue: [ ^nil ].

	byteSize > 1000 ifTrue: 
		[interpreterProxy success: 0.
		^nil].
	interpreterProxy ioFilename: translatedFilePath fromString: fontFilePath ofLength: byteSize resolveAliases: true.

	errorCode := self cCode: 'FT_New_Face(library, translatedFilePath, anInteger, &face)' 
					 inSmalltalk: [ 1000 ].
	self cCode: '' inSmalltalk: [ face := face ].
	self touch: face.

	interpreterProxy success: errorCode == 0.
	interpreterProxy failed ifTrue: [ ^nil ].

	self ftAllocateHandleInReceiverForPointer: face.
