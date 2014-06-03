displaying
fillBitmapSpan: bits from: leftX to: rightX
	"Fill the span buffer between leftEdge and rightEdge using the given bits.
	Note: We always start from zero - this avoids using huge bitmap buffers if the bitmap is to be displayed at the very far right hand side and also gives us a chance of using certain bitmaps (e.g., those with depth 32) directly."
	| x0 x1 x bitX colorMask colorShift baseShift fillValue |
	<inline: false>
	<var: #bits type:'int *'>

	x0 := leftX.
	x1 := rightX.
	bitX := -1. "Hack for pre-increment"
	self aaLevelGet = 1 ifTrue:["Speedy version for no anti-aliasing"
		[x0 < x1] whileTrue:[
			fillValue := (self cCoerce: bits to: 'int *') at: (bitX := bitX + 1).
			spanBuffer at: x0 put: fillValue.
			x0 := x0 + 1.
		].
	] ifFalse:["Generic version with anti-aliasing"
		colorMask := self aaColorMaskGet.
		colorShift := self aaColorShiftGet.
		baseShift := self aaShiftGet.
		[x0 < x1] whileTrue:[
			x := x0 >> baseShift.
			fillValue := (self cCoerce: bits to: 'int *') at: (bitX := bitX + 1).
			fillValue := (fillValue bitAnd: colorMask) >> colorShift.
			spanBuffer at: x put: (spanBuffer at: x) + fillValue.
			x0 := x0 + 1.
		].
	].
	x1 > self spanEndGet ifTrue:[self spanEndPut: x1].
	x1 > self spanEndAAGet ifTrue:[self spanEndAAPut: x1].