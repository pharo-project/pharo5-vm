nbody
addMomentumTo: anArray
	anArray at: 1 put: (anArray at: 1) + (vx * mass).
	anArray at: 2 put: (anArray at: 2) + (vy * mass).
	anArray at: 3 put: (anArray at: 3) + (vz * mass).
	^anArray