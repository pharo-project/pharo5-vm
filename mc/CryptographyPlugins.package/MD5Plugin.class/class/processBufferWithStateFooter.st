code generation
processBufferWithStateFooter

	^ '
	state at: 0 put: (state at: 0) + a.
	state at: 1 put: (state at: 1) + b.
	state at: 2 put: (state at: 2) + c.
	state at: 3 put: (state at: 3) + d.'