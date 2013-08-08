accessing
volume: aNumber
	"If this envelope controls volume, set its scale to the given number. Otherwise, do nothing."

	updateSelector = #volume: ifTrue: [self scale: aNumber].
