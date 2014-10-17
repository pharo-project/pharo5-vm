benchmarking
benchDeltaBlue
	"This the combined benchmark."
	
	| n |
	
	n := self problemSize.
	
	DBStrength initialize.
	
	self doChain: n. 
	self doProjection: n