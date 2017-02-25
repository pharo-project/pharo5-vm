processing-LF
qu: u phi: phi cosphi: cosphi sinphi: sinphi rphid: rphid
	| expuphi |
	<returnTypeC: 'float'>
	<var: 'u' type: 'float '>
	<var: 'phi' type: 'float '>
	<var: 'cosphi' type: 'float '>
	<var: 'sinphi' type: 'float '>
	<var: 'rphid' type: 'float '>
	<var: 'expuphi' type: 'float '>
	expuphi := (u * phi) exp.
	^ expuphi * ((rphid * (u*u + 1.0) + u) * sinphi - cosphi) + 1.0