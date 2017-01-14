displaying
fillSpan: fill from: leftX to: rightX
	"Fill the span buffer from leftX to rightX with the given fill.
	Clip before performing any operations. Return true if the fill must
	be handled by some Smalltalk code."
	| x0 x1 type |
	<var: #fill type: 'unsigned int'>
	<inline: false>
	fill = 0 ifTrue:[^false]. "Nothing to do"
	"Start from spEnd - we must not paint pixels twice at a scan line"
	leftX < self spanEndAAGet 
		ifTrue:[x0 := self spanEndAAGet]
		ifFalse:[x0 := leftX].
	rightX > (self spanSizeGet << self aaShiftGet) 
		ifTrue:[x1 := (self spanSizeGet << self aaShiftGet)]
		ifFalse:[x1 := rightX].

	"Clip left and right values"
	x0 < self fillMinXGet ifTrue:[x0 := self fillMinXGet].
	x1 > self fillMaxXGet ifTrue:[x1 := self fillMaxXGet].

	"Adjust start and end values of span"
	x0 < self spanStartGet ifTrue:[self spanStartPut: x0].
	x1 > self spanEndGet ifTrue:[self spanEndPut: x1].
	x1 > self spanEndAAGet ifTrue:[self spanEndAAPut: x1].

	x0 >= x1 ifTrue:[^false]. "Nothing to do"

	(self isFillColor: fill) ifTrue:[
		self fillColorSpan: fill from: x0 to: x1.
	] ifFalse:[
		"Store the values for the dispatch"
		self lastExportedFillPut: fill.
		self lastExportedLeftXPut: x0.
		self lastExportedRightXPut: x1.
		type := self fillTypeOf: fill.
		type <= 1 ifTrue:[^true].
		self dispatchOn: type in: FillTable.
	].
	^false