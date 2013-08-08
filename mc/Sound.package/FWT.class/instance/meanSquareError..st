testing
meanSquareError: otherData
	"Return the mean-square error between the current sample array and
	some other data, presumably to evaluate a compression scheme."
	| topSum bottomSum pointDiff |
	topSum := bottomSum := 0.0.
	1 to: nSamples do:
		[:i |  pointDiff := (samples at: i) - (otherData at: i).
		topSum := topSum + (pointDiff * pointDiff).
		bottomSum := bottomSum + ((otherData at: i) * (otherData at: i))].
	^ topSum / bottomSum