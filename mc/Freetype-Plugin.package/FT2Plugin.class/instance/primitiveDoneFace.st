primitives-FT2Face
primitiveDoneFace
	"Call the library to release the given face record.
	Nil out the pointer fields"
	| rcvr face |

	<var: #face type: 'FT_Face'>

	rcvr := self 
				primitive: 'primitiveDoneFace'
				parameters: #()
				receiver: #FT2Face.
	face := self ftHandleValueFromReceiver: rcvr.
	face isNil ifTrue: [^interpreterProxy primitiveFail].
	self touch: face.
	errorCode := self cCode: 'FT_Done_Face(face)'.

	"nil out all the fields"
	0 to: 23
		do: 
			[:i | 
			interpreterProxy 
				storePointer: i
				ofObject: rcvr
				withValue: interpreterProxy nilObject].
	interpreterProxy success: errorCode == 0