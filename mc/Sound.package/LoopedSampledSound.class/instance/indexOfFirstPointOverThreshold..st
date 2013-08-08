other
indexOfFirstPointOverThreshold: threshold
	"Answer the index of the first sample whose absolute value exceeds the given threshold."

	| s |
	leftSamples == rightSamples
		ifTrue: [
			1 to: lastSample do: [:i |
				s := leftSamples at: i.
				s < 0 ifTrue: [s := 0 - s].
				s > threshold ifTrue: [^ i]]]
		ifFalse: [
			1 to: lastSample do: [:i |
				s := leftSamples at: i.
				s < 0 ifTrue: [s := 0 - s].
				s > threshold ifTrue: [^ i].
				s := rightSamples at: i.
				s < 0 ifTrue: [s := 0 - s].
				s > threshold ifTrue: [^ i]]].
	^ lastSample + 1
