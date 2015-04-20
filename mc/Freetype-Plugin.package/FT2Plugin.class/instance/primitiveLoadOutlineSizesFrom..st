primitives-FT2Outline
primitiveLoadOutlineSizesFrom: aFace
	"Assumes that primitiveLoadGlyph:flags: has been called earlier to set face->glyph."
	| rcvr gs face |

	<var: #face type: 'FT_Face'>	"ptr to struct"
	<var: #gs declareC: 'FT_GlyphSlot gs'>	"ptr to struct"

	rcvr := self 
				primitive: 'primitiveLoadOutlineSizesFromFace'
				parameters: #(FT2Face)
				receiver: #FT2Outline.

	errorCode := 0.
	(interpreterProxy slotSizeOf: rcvr) < FT2OutlineInstSize 
		ifTrue: [^interpreterProxy primitiveFail].
	face := self ftHandleValueFromReceiver: aFace.
	face isNil ifTrue: [^interpreterProxy primitiveFail].
	gs := self cCode: 'face->glyph'.
	gs ifFalse: [^interpreterProxy primitiveFail].
	self touch: gs.
	
	interpreterProxy 
		storeInteger: FT2OutlineContoursSizeIndex 
		ofObject: rcvr
		withValue: (self cCode: 'gs->outline.n_contours' inSmalltalk: [gs]).
	
	interpreterProxy 
		storeInteger: FT2OutlinePointsSizeIndex 
		ofObject: rcvr
		withValue: (self cCode: 'gs->outline.n_points' inSmalltalk: [gs]).

"	Bug: there is no flags ivar in FT2Outline.	
	
	interpreterProxy 
		storeInteger: FT2OutlineFlagsIndex
		ofObject: rcvr
		withValue: (self cCode: 'gs->outline.flags' inSmalltalk: [gs])."
	
	
