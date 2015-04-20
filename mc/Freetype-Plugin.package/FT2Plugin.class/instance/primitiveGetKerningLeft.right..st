primitives-FT2Kerning
primitiveGetKerningLeft: leftGlyph right: rightGlyph
	| rcvr face pointOop kernMode result |

	<var: #face type: 'FT_Face'>	"ptr to struct"
	<var: #result type: 'FT_Vector'>

	self cCode: 'result.x=3; result.y=4;' inSmalltalk: [ result := 3@4 ].
	self touch: result.

	rcvr := self 
				primitive: 'primitiveGetKerningLeftRight'
				parameters: #(SmallInteger SmallInteger)
				receiver: #FT2Face.
	errorCode := 0.

	face := self ftHandleValueFromReceiver: rcvr.
	face isNil ifTrue: [^interpreterProxy primitiveFail].
	
	kernMode := self cCode: 'FT_KERNING_UNSCALED'.
	self touch: kernMode.
	
	self cCode: 'FT_Get_Kerning(face, leftGlyph, rightGlyph, kernMode, &result);'.
	
	pointOop := interpreterProxy 
				makePointwithxValue: (self cCode: 'result.x')
				yValue: (self cCode: 'result.y').
	^pointOop