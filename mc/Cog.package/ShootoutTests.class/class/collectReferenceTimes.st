benchmark scripts
collectReferenceTimes
	"Run the benchmarks 3 times and take their average, e.g. suitable
	 for filling in values for referenceTimesForClosureInterpreter"

	"ShootoutTests collectReferenceTimes"
	| n refs |
	Transcript clear.
	n := 3.
	refs := (1 to: n) collect: [:i| ShootoutTests runAllToInternalStream].
	^{	refs.
		(1 to: refs first size) collect:
			[:i|
			((refs inject: 0 into: [:sum :ref| (ref at: i) + sum]) / n) rounded] }