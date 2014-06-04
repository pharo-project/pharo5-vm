displaying
aaFirstPixelFrom: leftX to: rightX
	"Common function to compute the first full pixel for AA drawing"
	| firstPixel |
	<inline: true>
	firstPixel := (leftX + self aaLevelGet - 1) bitAnd: (self aaLevelGet - 1) bitInvert32.
	firstPixel > rightX 
		ifTrue:[^rightX]
		ifFalse:[^firstPixel]