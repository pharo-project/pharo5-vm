private
setPoints: pointList loopStart: startIndex loopEnd: endIndex

	| lastVal |
	points := pointList asArray collect: [:p | p x asInteger @ p y asFloat].
	loopStartIndex := startIndex.
	loopEndIndex := endIndex.
	self checkParameters.
	loopStartMSecs := (points at: loopStartIndex) x.
	loopMSecs := (points at: loopEndIndex) x - (points at: loopStartIndex) x.
	loopEndMSecs := nil.  "unknown end time; sustain until end time is known"
	scale ifNil: [scale := 1.0].
	decayScale ifNil: [decayScale := 1.0].

	"note if there are no changes during the loop phase"
	noChangesDuringLoop := true.
	lastVal := (points at: loopStartIndex) y.
	loopStartIndex to: loopEndIndex do: [:i | 
		(points at: i) y ~= lastVal ifTrue: [
			noChangesDuringLoop := false.
			^ self]].
