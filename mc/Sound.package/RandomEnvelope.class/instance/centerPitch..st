accessing
centerPitch: aNumber
	"If this envelope controls pitch, set its scale to the given number. Otherwise, do nothing."

	updateSelector = #pitch: ifTrue: [self scale: aNumber].
