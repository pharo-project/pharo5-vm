primitives-FT2Face
primitiveNewMemoryFaceFrom: aFreeTypeExternalMemory size: byteSize index: anInteger
	"Fill in the receiver's (a FT2Face object) fields
	from the address and fields of a newly opened FT_Face object."
	| rcvr face memPointer |
	
	<var: #face type: 'FT_Face'>	"a pointer"
	<var: #memPointer declareC: 'void *memPointer'>

	rcvr := self primitive: 'primitiveNewMemoryFaceFromExternalMemoryAndIndex'
		parameters: #(Oop SmallInteger SmallInteger)
		receiver: #FT2Face.
		
	self touch: rcvr.

	errorCode := 0.

	memPointer := self ftHandleValueFromReceiver: aFreeTypeExternalMemory.
	self touch: memPointer.
	interpreterProxy failed ifTrue: [ ^nil ].
	
	errorCode := self cCode: 'FT_New_Memory_Face(library, memPointer, byteSize, anInteger, &face)' 
					 inSmalltalk: [ 1000 ].
	self cCode: '' inSmalltalk: [ face := face ].
	self touch: face.

	interpreterProxy success: errorCode == 0.
	interpreterProxy failed 
		ifTrue: [ ^nil ].

	self ftAllocateHandleInReceiverForPointer: face.
