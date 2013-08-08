testing
samplesPerCycleForIndex: i
	"Answer the number of samples per cycle corresponding to a power peak at the given index. Answer zero if i = 1, since an index of 1 corresponds to the D.C. component."

	| windowSize |
	windowSize := 2 raisedTo: nu.
	(i < 1 or: [i > (windowSize // 2)]) ifTrue: [^ self error: 'index is out of range'].
	i = 1 ifTrue: [^ 0].  "the D.C. component"
	^ windowSize asFloat / (i - 1)
