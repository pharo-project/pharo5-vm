primitives-FT2Kerning
primitiveHasKerning
	| rcvr face |

	<var: #face type: 'FT_Face'>	"ptr to struct"

	rcvr := self 
				primitive: 'primitiveHasKerning'
				parameters: #()
				receiver: #FT2Face.
	errorCode := 0.

	face := self ftHandleValueFromReceiver: rcvr.
	face isNil ifTrue: [^interpreterProxy primitiveFail].
	
	^interpreterProxy integerObjectOf: (self cCode: 'FT_HAS_KERNING( face )')
