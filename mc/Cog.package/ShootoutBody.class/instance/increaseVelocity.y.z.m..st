nbody
increaseVelocity: dx y: dy z: dz m: m
	vx := vx + (dx * m).
	vy := vy + (dy * m).
	vz := vz + (dz * m)