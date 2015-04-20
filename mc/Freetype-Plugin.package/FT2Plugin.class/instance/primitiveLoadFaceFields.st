primitives-FT2Face
primitiveLoadFaceFields
	"Fill in many of the receiver's (an FT2Face) fields (other than its handle)
	from the FT_Face record that it points to."
	| rcvr face strOop |

	<var: #face type: 'FT_Face'>
	
	rcvr := self 
				primitive: 'primitiveLoadFaceFields'
				parameters: #()
				receiver: #FT2Face.
	face := self ftHandleValueFromReceiver: rcvr.
	face isNil ifTrue: [^interpreterProxy primitiveFail].
	self touch: face.

	"handle is first slot and is already loaded."

	"numFaces"
	interpreterProxy 
		storeInteger: 1
		ofObject: rcvr
		withValue: (self cCode: 'face->num_faces').

	"faceIndex"
	interpreterProxy 
		storeInteger: 2
		ofObject: rcvr
		withValue: (self cCode: 'face->face_index').

	"faceFlags"
	interpreterProxy 
		storeInteger: 3
		ofObject: rcvr
		withValue: (self cCode: 'face->face_flags').

	"styleFlags"
	interpreterProxy 
		storeInteger: 4
		ofObject: rcvr
		withValue: (self cCode: 'face->style_flags').

	"numGlyphs"
	interpreterProxy 
		storeInteger: 5
		ofObject: rcvr
		withValue: (self cCode: 'face->num_glyphs').

	"familyName"
	interpreterProxy pushRemappableOop: rcvr.
	strOop := self 
				ftAllocateStringForPointer: (self cCode: 'face->family_name').
	rcvr := interpreterProxy popRemappableOop.
	interpreterProxy 
		storePointer: 6
		ofObject: rcvr
		withValue: strOop.

	"styleName"
	interpreterProxy pushRemappableOop: rcvr.
	strOop := self 
				ftAllocateStringForPointer: (self cCode: 'face->style_name').
	rcvr := interpreterProxy popRemappableOop.
	interpreterProxy 
		storePointer: 7
		ofObject: rcvr
		withValue: strOop.

	"numFixedSizes"
	interpreterProxy 
		storeInteger: 8
		ofObject: rcvr
		withValue: (self cCode: 'face->num_fixed_sizes').

	"availableSizes -- array of FT2BitmapSize records"

	"numCharmaps"
	interpreterProxy 
		storeInteger: 10
		ofObject: rcvr
		withValue: (self cCode: 'face->num_charmaps').

	"charmaps -- array of FT2CharMap records"
	(self cCode: 'face->face_flags & FT_FACE_FLAG_SCALABLE') 
		ifTrue: 
			["bbox -- Rectangle xMin, yMin, xMax, yMax"

			"unitsPerEm"

			interpreterProxy 
				storeInteger: 13
				ofObject: rcvr
				withValue: (self cCode: 'face->units_per_EM').

			"ascender"
			interpreterProxy 
				storeInteger: 14
				ofObject: rcvr
				withValue: (self cCode: 'face->ascender').

			"descender"
			interpreterProxy 
				storeInteger: 15
				ofObject: rcvr
				withValue: (self cCode: 'face->descender').

			"height"
			interpreterProxy 
				storeInteger: 16
				ofObject: rcvr
				withValue: (self cCode: 'face->height').

			"maxAdvanceWidth"
			interpreterProxy 
				storeInteger: 17
				ofObject: rcvr
				withValue: (self cCode: 'face->max_advance_width').

			"maxAdvanceHeight"
			interpreterProxy 
				storeInteger: 18
				ofObject: rcvr
				withValue: (self cCode: 'face->max_advance_height').

			"underlinePosition"
			interpreterProxy 
				storeInteger: 19
				ofObject: rcvr
				withValue: (self cCode: 'face->underline_position').

			"underlineThickness"
			interpreterProxy 
				storeInteger: 20
				ofObject: rcvr
				withValue: (self cCode: 'face->underline_thickness')]

	"glyph"