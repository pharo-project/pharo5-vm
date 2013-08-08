accessing
ratio: freqRatio
	"Set the FM modulation to carrier frequency ratio."
	"Warning: This method is intended primarily for use by envelopes. For efficiency during envelope processing, this change will not take effect until internalizeModulationAndRatio is called."

	multiplier := freqRatio asFloat.
