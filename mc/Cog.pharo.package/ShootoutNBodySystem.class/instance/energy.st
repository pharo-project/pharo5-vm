nbody
energy
	| e |
	e := 0.0.
	1 to: bodies size do: [:i|
		e := e + (bodies at: i) kineticEnergy.

		i+1 to: bodies size do: [:j|
			e := e - ((bodies at: i) potentialEnergy: (bodies at: j))].
	].
	^e