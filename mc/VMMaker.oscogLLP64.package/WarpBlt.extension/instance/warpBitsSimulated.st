*VMMaker-Interpreter-system simulation
warpBitsSimulated
	"Simulate WarpBlt"

	cellSize < 1 ifTrue: [ ^self error: 'cellSize must be >= 1' ].

	self warpBitsSimulated: cellSize
		sourceMap: (sourceForm colormapIfNeededForDepth: 32).
