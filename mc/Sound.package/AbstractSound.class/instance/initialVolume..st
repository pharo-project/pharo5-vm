volume
initialVolume: vol
	"Set the initial volume of this sound to the given volume, a number in the range [0.0..1.0]."

	scaledVol := (((vol asFloat min: 1.0) max: 0.0) * ScaleFactor) rounded.
	scaledVolLimit := scaledVol.
	scaledVolIncr := 0.
