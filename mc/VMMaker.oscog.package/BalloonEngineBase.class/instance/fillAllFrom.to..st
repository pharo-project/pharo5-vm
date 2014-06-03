displaying
fillAllFrom: leftX to: rightX
	"Fill the span buffer from leftX to rightX with the given fill."
	| fill startX stopX |
	<inline: true>
	fill := self topFill.
	startX := leftX.
	stopX := self topRightX.
	[stopX < rightX] whileTrue:[
		fill := self makeUnsignedFrom: self topFill.
		fill = 0 ifFalse:[
			(self fillSpan: fill from: startX to: stopX) ifTrue:[^true]].
		self quickRemoveInvalidFillsAt: stopX.
		startX := stopX.
		stopX := self topRightX].
	fill := self makeUnsignedFrom: self topFill.
	fill = 0 ifFalse:[^self fillSpan: fill from: startX to: rightX].
	^false