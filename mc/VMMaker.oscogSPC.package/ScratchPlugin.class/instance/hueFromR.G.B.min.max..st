private
hueFromR: r G: g B: b min: min max: max
	"Answer the hue, an angle between 0 and 360."

	| span result |
	<inline: true>

	span := max - min.
	span = 0 ifTrue: [^ 0].

	r = max
		ifTrue: [result := ((60 * (g - b)) // span)]
		ifFalse: [
			g = max
				ifTrue: [result := 120 + ((60 * (b - r)) // span)]
				ifFalse: [result := 240 + ((60 * (r - g)) // span)]].

	result < 0 ifTrue: [^ result + 360].
	^ result
