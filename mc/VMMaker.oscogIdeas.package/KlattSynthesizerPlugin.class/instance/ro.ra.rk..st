processing-LF
ro: roNumber ra: raNumber rk: rkNumber
	| r d phi cosphi sinphi rphid u theta rho gamma gammapwr te ro ra rk |

	<returnTypeC: 'void'>
	<var: 'roNumber' type: 'float '>
	<var: 'raNumber' type: 'float '>
	<var: 'rkNumber' type: 'float '>
	<var: 'r' type: 'float '>
	<var: 'd' type: 'float '>
	<var: 'phi' type: 'float '>
	<var: 'cosphi' type: 'float '>
	<var: 'sinphi' type: 'float '>
	<var: 'rphid' type: 'float '>
	<var: 'u' type: 'float '>
	<var: 'theta' type: 'float '>
	<var: 'rho' type: 'float '>
	<var: 'gamma' type: 'float '>
	<var: 'gammapwr' type: 'float '>
	<var: 'ro' type: 'float '>
	<var: 'ra' type: 'float '>
	<var: 'rk' type: 'float '>

	te := (t0 * roNumber) asInteger.
	ro := te asFloat / t0 asFloat.
	rk := rkNumber.
	ra := raNumber.

	ra <= 0.0
		ifTrue: [d := 1.0]
		ifFalse: [r := 1.0 - ro / ra.
				d := 1.0 - (r / (r exp - 1.0))].

	phi := PI * (rk + 1.0).
	cosphi := phi cos.
	sinphi := phi sin.
	rphid := ra / ro * phi * d.

	u := self zeroQphi: phi cosphi: cosphi sinphi: sinphi rphid: rphid.
	theta := phi / te.
	rho := (u * theta) exp.
	a1 := 2.0 * theta cos * rho.
	a2 := 0.0 - (rho * rho).
	x2 := 0.0.
	x1 := rho * theta sin.

	gamma := (-1.0 / (ra * t0)) exp.
	gammapwr := gamma raisedTo: t0 - te.

	b1 := gamma.
	c1 := (1.0 - gamma) * gammapwr / (1.0 - gammapwr).

	self normalizeGlottalPulse