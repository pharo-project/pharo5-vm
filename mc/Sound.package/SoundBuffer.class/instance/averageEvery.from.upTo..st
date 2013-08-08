utilities
averageEvery: nSamples from: anotherBuffer upTo: inCount

	| fromIndex sum |

	fromIndex := 1.
	1 to: inCount // nSamples do: [ :i |
		sum := 0.
		nSamples timesRepeat: [
			sum := sum + (anotherBuffer at: fromIndex).
			fromIndex := fromIndex + 1.
		].
		self at: i put: sum // nSamples.
	].
