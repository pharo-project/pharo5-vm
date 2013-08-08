accessing
modulation: mod
	"Set the FM modulation index. Typical values range from 0 (no modulation) to 5, although values up to about 10 are sometimes useful."
	"Warning: This method is intended primarily for use by envelopes. For efficiency during envelope processing, this change will not take effect until internalizeModulationAndRatio is called."

	modulation := mod asFloat.
