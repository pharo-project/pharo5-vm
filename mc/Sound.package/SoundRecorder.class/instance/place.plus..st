trimming
place: startPlace plus: nSamples
	"Return the place that is nSamples (may be negative) beyond thisPlace."

	| i j remaining buf |
	i := startPlace first.
	j := startPlace second.
	nSamples >= 0
	ifTrue: [remaining := nSamples.
			[buf := recordedBuffers at: i.
			(j + remaining) <= buf size ifTrue: [^ Array with: i with: j + remaining].
			i < recordedBuffers size]
				whileTrue: [remaining := remaining - (buf size - j + 1).
							i := i+1.  j := 1].
			^ self endPlace]
	ifFalse: [remaining := nSamples negated.
			[buf := recordedBuffers at: i.
			(j - remaining) >= 1 ifTrue: [^ Array with: i with: j - remaining].
			i > 1]
				whileTrue: [remaining := remaining - j.
							i := i-1.  j := (recordedBuffers at: i) size].
			^ #(1 1)]