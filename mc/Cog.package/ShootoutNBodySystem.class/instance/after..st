nbody
after: dt
	1 to: bodies size do: [:i|
		i+1 to: bodies size do: [:j|
			(bodies at: i) and: (bodies at: j) velocityAfter: dt].
	].
	bodies do: [:each| each positionAfter: dt]