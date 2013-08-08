bulk processing
transformDataFrom: anIndexableCollection startingAt: index
	"Forward transform a block of real data taken from from the given indexable collection starting at the given index. Answer a block of values representing the normalized magnitudes of the frequency components."

	| j real imag out |
	j := 0.
	index to: index + n - 1 do: [:i |
		realData at: (j := j + 1) put: (anIndexableCollection at: i)].
	realData *= window.
	imagData := FloatArray new: n.
	self transformForward: true.

	"compute the magnitudes of the complex results"
	"note: the results are in bottom half; the upper half is just its mirror image"
	real := realData copyFrom: 1 to: (n / 2).
	imag := imagData copyFrom: 1 to: (n / 2).
	out := (real * real) + (imag * imag).
	1 to: out size do: [:i | out at: i put: (out at: i) sqrt].
	^ out
