primitives-FT2GlyphSlot
primitiveGetPostscriptName
	"return a String"
	| face rcvr string buffer |

	<var: #face type: 'FT_Face'>	"ptr to struct"
	<var: #buffer type: 'char*'>

	rcvr := self 
				primitive: 'primitiveGetPostscriptName'
				parameters: #()
				receiver: #FT2Face.
	buffer := 0.
	face := self ftHandleValueFromReceiver: rcvr.
	face isNil ifTrue: [^interpreterProxy primitiveFail].
	self cCode: 'buffer = FT_Get_Postscript_Name(face)'.
	interpreterProxy success: buffer ~= 0.  
	interpreterProxy failed ifTrue: [^nil].
	string := self ftAllocateStringForPointer: buffer.
	^string