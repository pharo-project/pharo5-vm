primitives-FT2Face
primitiveGetFaceCharIndex: charIndex 
	"Return the Freetype glyph index of the given character code, in the 
	current encoding. 
	Return value of 0 means 'undefined character code'."
	| rcvr face result |

	<var: #face type: 'FT_Face'>

	rcvr := self 
				primitive: 'primitiveGetFaceCharIndex'
				parameters: #(SmallInteger)
				receiver: #FT2Face.
	errorCode := 0.

	face := self ftHandleValueFromReceiver: rcvr.
	face isNil ifTrue: [^interpreterProxy primitiveFail].

	result := self cCode: 'FT_Get_Char_Index(face, charIndex)'.
	^interpreterProxy positive32BitIntegerFor: result
