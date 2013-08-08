nbody
offsetMomentum: anArray
	| m |
	m := self class solarMass.
	vx := (anArray at: 1) negated / m.
	vy := (anArray at: 2) negated / m.
	vz := (anArray at: 3) negated / m