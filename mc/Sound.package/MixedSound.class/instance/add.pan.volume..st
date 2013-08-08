composition
add: aSound pan: leftRightPan volume: volume
	"Add the given sound with the given left-right pan, where 0.0 is full left, 1.0 is full right, and 0.5 is centered. The loudness of the sound will be scaled by volume, which ranges from 0 to 1.0."

	| pan vol |
	pan := ((leftRightPan * ScaleFactor) asInteger max: 0) min: ScaleFactor.
	vol := ((volume * ScaleFactor) asInteger max: 0) min: ScaleFactor.
	sounds := sounds copyWith: aSound.
	leftVols := leftVols copyWith: ((ScaleFactor - pan) * vol) // ScaleFactor.
	rightVols := rightVols copyWith: (pan * vol) // ScaleFactor.
