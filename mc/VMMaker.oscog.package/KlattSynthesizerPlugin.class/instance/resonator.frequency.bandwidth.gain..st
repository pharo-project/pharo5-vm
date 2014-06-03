resonators
resonator: index frequency: freq bandwidth: bw gain: gain
	"Convert formant frequencies and bandwidth into
	resonator difference equation coefficients."
	<returnTypeC: 'void'>
	<var: 'freq' type: 'float '>
	<var: 'bw' type: 'float '>
	<var: 'gain' type: 'float '>
	self resonator: index frequency: freq bandwidth: bw.
	self resonatorA: index put: (self resonatorA: index) * gain