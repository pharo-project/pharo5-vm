resonators
antiResonator: index frequency: freq bandwidth: bw
	"Set up an anti-resonator"
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
	a := 1.0 / a.
	b := 0.0 - b * a.
	c := 0.0 - c * a.
	self resonatorA: index put: a.
	self resonatorB: index put: b.
	self resonatorC: index put: c