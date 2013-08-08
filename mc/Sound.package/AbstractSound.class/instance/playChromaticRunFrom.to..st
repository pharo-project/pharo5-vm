playing
playChromaticRunFrom: startPitch to: endPitch
	"Play a fast chromatic run between the given pitches. Useful for auditioning a sound."

	(AbstractSound chromaticRunFrom: startPitch to: endPitch on: self) play.
