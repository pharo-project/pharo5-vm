as yet unclassified
reset
	"Reset the state for this envelope."

	super reset.
	target initialVolume: points first y * scale.
	nextRecomputeTime := 0.
