utilities
trimmedThreshold: threshold

	| start end |
	start := self indexOfFirstSampleOver: threshold.
	end :=  self indexOfLastSampleOver: threshold.
	start > end ifTrue: [^ SoundBuffer new].
	start := (start - 200) max: 1.
	end := (end + 200) min: self size.
	^ self copyFrom: start to: end
