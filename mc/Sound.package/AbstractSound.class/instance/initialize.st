initialization
initialize
	super initialize.
	envelopes := #().
	mSecsSinceStart := 0.
	samplesUntilNextControl := 0.
	scaledVol := (1.0 * ScaleFactor) rounded.
	scaledVolIncr := 0.
	scaledVolLimit := scaledVol.
