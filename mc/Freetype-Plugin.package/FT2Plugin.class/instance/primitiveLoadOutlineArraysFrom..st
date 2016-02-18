primitives-FT2Outline
primitiveLoadOutlineArraysFrom: aFace
	"Assumes that primitiveLoadGlyph:flags: has been called earlier to set face->glyph."
	| rcvr gs face points tags pointsSize contours contoursSize |

	<var: #face type: 'FT_Face'>	"ptr to struct"
	<var: #gs declareC: 'FT_GlyphSlot gs'>	"ptr to struct"
	<var: #points type:  'long *' >
	<var: #contours type: 'short *'>
	<var: #tags type: 'char*'>
	
	rcvr := self 
				primitive: 'primitiveLoadOutlineArraysFromFace'
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

	pointsSize :=  self cCode: 'gs->outline.n_points'.
	points :=  self fetchWordArray: FT2OutlinePointsIndex ofObject: rcvr assureSize:  pointsSize * 2.
	points isNil ifTrue: [^interpreterProxy primitiveFail].
	
	tags :=  self fetchByteArray: FT2OutlineTagsIndex ofObject: rcvr assureSize:  pointsSize.
	tags isNil ifTrue: [^interpreterProxy primitiveFail].

	0 to: pointsSize - 1 do: [ :i |
		points at: (2*i) 		put: (self cCode: 'gs->outline.points[i].x').		
		points at: (2*i)+1 	put: (self cCode: 'gs->outline.points[i].y').		
		tags at: i put: (self cCode: 'gs->outline.tags[i]').		
	]. 


	contoursSize := self cCode: 'gs->outline.n_contours'.
	contours := self fetchShortArray: FT2OutlineContoursIndex ofObject: rcvr assureSize: contoursSize.

	0 to: contoursSize - 1 do: [ :i |
		contours at: i put: (self cCode: 'gs->outline.contours[i]').	
	]

	
