resonators
resonator: index frequency: freq bandwidth: bw
	"Convert formant frequencies and bandwidth into
	resonator difference equation coefficients."
	| arg r a b c |
	<returnTypeC: 'void'>
	<var: 'freq' type: 'float '>
	<var: 'bw' type: 'float '>
	<var: 'arg' type: 'double '>
	<var: 'a' type: 'float '>
	<var: 'b' type: 'float '>
	<var: 'c' type: 'float '>
	<var: 'r' type: 'float '>
	arg := 0.0 - PI / samplingRate * bw.
	r := arg exp.
	c := 0.0 - (r * r).
	arg := PI * 2.0 / samplingRate * freq.
	b := r * arg cos * 2.0.
	a := 1.0 - b - c.
	self resonatorA: index put: a.
	self resonatorB: index put: b.
	self resonatorC: index put: c