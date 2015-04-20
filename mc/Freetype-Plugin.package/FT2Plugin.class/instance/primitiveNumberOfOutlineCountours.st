primitives-FT2GlyphSlot
primitiveNumberOfOutlineCountours
	"Assumes that primitiveLoadGlyph:flags: has been called earlier to set face->glyph."
	| rcvr gs face aFace contoursSize |

	<var: #face type: 'FT_Face'>	"ptr to struct"
	<var: #gs declareC: 'FT_GlyphSlot gs'>	"ptr to struct"

	rcvr := self 
				primitive: 'primitiveNumberOfOutlineCountours'
				parameters: #()
				receiver: #FT2GlyphSlot.

	errorCode := 0.
	(interpreterProxy slotSizeOf: rcvr) < FT2GlyphSlotInstSize 
		ifTrue: [^interpreterProxy primitiveFail].
	aFace := interpreterProxy fetchPointer: FT2GlyphSlotFaceIndex ofObject: rcvr.
	face := self ftHandleValueFromReceiver: aFace .
	face isNil ifTrue: [^interpreterProxy primitiveFail].

	gs := self cCode: 'face->glyph' inSmalltalk: [face].
	gs ifFalse: [^interpreterProxy primitiveFail].
	self touch: gs.

	contoursSize := self cCode: 'gs->outline.n_contours' inSmalltalk: [gs].
	
	^interpreterProxy integerObjectOf: contoursSize.
	
	
