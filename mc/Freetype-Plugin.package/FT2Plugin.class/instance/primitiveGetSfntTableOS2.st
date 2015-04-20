primitives-FT2GlyphSlot
primitiveGetSfntTableOS2
	"return the bytes from the OS/2 table"
	| face rcvr buffer returnedHandle extraByteArrayPtr |

	<var: #face type: 'FT_Face'>	"ptr to struct"
	<var: #extraByteArrayPtr declareC: 'char *extraByteArrayPtr'>
	"<var: #aPointer declareC: 'const char *aPointer'>"
	<var: #buffer declareC: 'char *buffer'>

	rcvr := self 
				primitive: 'primitiveGetSfntTableOS2'
				parameters: #()
				receiver: #FT2Face.
	buffer := 0.
	face := self ftHandleValueFromReceiver: rcvr.
	face isNil ifTrue: [^interpreterProxy primitiveFail].
	self cCode: 'buffer = FT_Get_Sfnt_Table(face,ft_sfnt_os2)'.
	buffer = 0 ifTrue: [^ -1 asSmallIntegerObj].
	returnedHandle := interpreterProxy
						instantiateClass: interpreterProxy classByteArray
						indexableSize: (self cCode: 'sizeof(TT_OS2)').
	"Copy from the C bytecode buffer to the Smalltalk ByteArray"
	extraByteArrayPtr := interpreterProxy arrayValueOf: returnedHandle.
	self touch: extraByteArrayPtr.
	self cCode: 'memcpy(extraByteArrayPtr, buffer, sizeof(TT_OS2))'.
	^ returnedHandle
