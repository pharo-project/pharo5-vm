primitives-FT2GlyphSlot
primitiveLoadGlyphSlotFrom: aFace 
	"Assumes that primitiveLoadGlyph:flags: has been called earlier to set face->glyph."
	| rcvr face gfOop gfPtr gs btw |

	<var: #face type: 'FT_Face'>	"ptr to struct"
	<var: #gs declareC: 'FT_GlyphSlot gs'>	"ptr to struct"
	<var: #gfPtr declareC: 'FT_Glyph_Format *gfPtr'>

	rcvr := self 
				primitive: 'primitiveLoadGlyphSlotFromFace'
				parameters: #(#FT2Face)
				receiver: #FT2GlyphSlot.
	errorCode := 0.
	(interpreterProxy slotSizeOf: rcvr) < 8 
		ifTrue: [^interpreterProxy primitiveFail].
	face := self ftHandleValueFromReceiver: aFace.
	face isNil ifTrue: [^interpreterProxy primitiveFail].
	gs := self cCode: 'face->glyph'.
	gs ifFalse: [^interpreterProxy primitiveFail].
	self touch: gs.

	"face 0"
	interpreterProxy 
		storePointer: 0
		ofObject: rcvr
		withValue: aFace.

	"linearHorizontalAdvance 1"
	interpreterProxy 
		storeInteger: 1
		ofObject: rcvr
		withValue: (self cCode: 'gs->linearHoriAdvance').

	"linearVerticalAdvance 2"
	interpreterProxy 
		storeInteger: 2
		ofObject: rcvr
		withValue: (self cCode: 'gs->linearVertAdvance').

	"advanceX 3"
	interpreterProxy 
		storeInteger: 3
		ofObject: rcvr
		withValue: (self cCode: 'gs->advance.x').

	"advanceY 4"
	interpreterProxy 
		storeInteger: 4
		ofObject: rcvr
		withValue: (self cCode: 'gs->advance.y').

	"format 5"
	interpreterProxy pushRemappableOop: rcvr.
	gfOop := interpreterProxy 
				instantiateClass: interpreterProxy classByteArray
				indexableSize: (self cCode: 'sizeof(FT_Glyph_Format)').
	self touch: gfOop.
	btw := 8. "self bytesPerWord"
	gfPtr := self cCode: '(FT_Glyph_Format *) pointerForOop(gfOop + btw)'.
	self touch: gfPtr.
	interpreterProxy failed ifTrue: [^nil].
	self cCode: '*gfPtr = gs->format'.
	rcvr := interpreterProxy popRemappableOop.
	interpreterProxy 
		storePointer: 5
		ofObject: rcvr
		withValue: gfOop.

	"bitmapLeft 6"
	interpreterProxy 
		storeInteger: 6
		ofObject: rcvr
		withValue: (self cCode: 'gs->bitmap_left').

	"bitmapTop 7"
	interpreterProxy 
		storeInteger: 7
		ofObject: rcvr
		withValue: (self cCode: 'gs->bitmap_top').

	"width 8"
	interpreterProxy 
		storeInteger: 8
		ofObject: rcvr
		withValue: (self cCode: 'gs->metrics.width').

	"height 9"
	interpreterProxy 
		storeInteger: 9
		ofObject: rcvr
		withValue: (self cCode: 'gs->metrics.height').

	"hBearingX 10"
	interpreterProxy 
		storeInteger: 10
		ofObject: rcvr
		withValue: (self cCode: 'gs->metrics.horiBearingX').

	"hBearingY 11"
	interpreterProxy 
		storeInteger: 11
		ofObject: rcvr
		withValue: (self cCode: 'gs->metrics.horiBearingY').

	"hAdvance 12"
	interpreterProxy 
		storeInteger: 12
		ofObject: rcvr
		withValue: (self cCode: 'gs->metrics.horiAdvance').

	"vBearingX 13"
	interpreterProxy 
		storeInteger: 13
		ofObject: rcvr
		withValue: (self cCode: 'gs->metrics.vertBearingX').

	"vBearingY 14"
	interpreterProxy 
		storeInteger: 14
		ofObject: rcvr
		withValue: (self cCode: 'gs->metrics.vertBearingY').

	"vAdvance 15"
	interpreterProxy 
		storeInteger: 15
		ofObject: rcvr
		withValue: (self cCode: 'gs->metrics.vertAdvance')