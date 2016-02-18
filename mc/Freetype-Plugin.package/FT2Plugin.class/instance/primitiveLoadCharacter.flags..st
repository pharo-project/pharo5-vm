primitives-FT2Face
primitiveLoadCharacter: index flags: flags 
	"Load the glyph at the given index in the current charmap.
	The default map upon opening a font is the 'unic' or Unicode charmap, if any."
	| face rcvr |
	
	<var: #face declareC: 'FT_Face face'>
	
	rcvr := self 
				primitive: 'primitiveLoadCharacter'
				parameters: #(#SmallInteger #SmallInteger)
				receiver: #FT2Face.
	face := self ftHandleValueFromReceiver: rcvr.
	face isNil ifTrue: [^interpreterProxy primitiveFail].
	errorCode := self cCode: 'FT_Load_Char(face, index, flags)'.
	interpreterProxy success: errorCode == 0.
	interpreterProxy failed ifTrue: [^nil]