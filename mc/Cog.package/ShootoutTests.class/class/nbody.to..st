benchmarking
nbody: count to: output
	| bodies |
	bodies := ShootoutNBodySystem new initialize.

	output print: bodies energy digits: 9; cr.
	count timesRepeat: [bodies after: 0.01].
	output print: bodies energy digits: 9; cr.
	^''