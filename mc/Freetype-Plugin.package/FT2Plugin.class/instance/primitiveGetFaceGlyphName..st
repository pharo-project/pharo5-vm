primitives-FT2Face
primitiveGetFaceGlyphName: glyphIndex 
	"return a String"
	| face rcvr string buffer |
	
	<var: #face type: 'FT_Face'>
	<var: #buffer declareC: 'char buffer[100]'>
	
	rcvr := self 
				primitive: 'primitiveGetFaceGlyphName'
				parameters: #(#SmallInteger)
				receiver: #FT2Face.
	face := self ftHandleValueFromReceiver: rcvr.
	face isNil ifTrue: [^interpreterProxy primitiveFail].
	errorCode := self 
				cCode: 'FT_Get_Glyph_Name(face, glyphIndex, buffer, 100)'.
	interpreterProxy success: errorCode == 0.
	interpreterProxy failed ifTrue: [^nil].
	string := self ftAllocateStringForPointer: buffer.
	^string