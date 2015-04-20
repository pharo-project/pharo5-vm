primitives-FT2Face
primitiveDoneFacePreserveFields
	"Call the library to release the given face record.
	Nil out the handle field, but do not nil the other fields,
	as their values are needed even if the face cannot be re-opened
	in the future due to a missing font file etc."
	| rcvr face |

	<var: #face type: 'FT_Face'>
	
	rcvr := self 
				primitive: 'primitiveDoneFacePreserveFields'
				parameters: #()
				receiver: #FT2Face.
	face := self ftHandleValueFromReceiver: rcvr.
	face isNil ifTrue: [^interpreterProxy primitiveFail].
	self touch: face.
	errorCode := self cCode: 'FT_Done_Face(face)'.
	"nil the handle field"
	interpreterProxy storePointer: 0 ofObject: rcvr withValue: interpreterProxy nilObject.
	interpreterProxy success: errorCode == 0