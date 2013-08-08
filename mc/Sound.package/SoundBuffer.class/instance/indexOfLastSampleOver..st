utilities
indexOfLastSampleOver: threshold
	"Return the index of the last sample whose absolute value is over the given threshold value. Return zero if no sample is over the threshold."

	self size to: 1 by: -1 do: [:i |
		(self at: i) abs > threshold ifTrue: [^ i]].
	^ 0
