nbody
and: aBody velocityAfter: dt
	| dx dy dz distance mag |
	dx := x - aBody x.
	dy := y - aBody y.
	dz := z - aBody z.

	distance := ((dx*dx) + (dy*dy) + (dz*dz)) sqrt.
	mag := dt / (distance * distance * distance).

	self decreaseVelocity: dx y: dy z: dz m: aBody mass * mag.
	aBody increaseVelocity: dx y: dy z: dz m: mass * mag