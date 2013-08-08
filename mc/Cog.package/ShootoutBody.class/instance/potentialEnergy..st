nbody
potentialEnergy: aBody
	| dx dy dz distance |
	dx := x - aBody x.
	dy := y - aBody y.
	dz := z - aBody z.

	distance := ((dx*dx) + (dy*dy) + (dz*dz)) sqrt.
	^mass * aBody mass / distance