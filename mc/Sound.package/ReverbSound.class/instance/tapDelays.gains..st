accessing
tapDelays: delayList gains: gainList
	"ReverbSound new tapDelays: #(537 691 1191) gains: #(0.07 0.07 0.07)"

	| maxDelay gain d |
	delayList size = gainList size
		ifFalse: [self error: 'tap delay and gains lists must be the same size'].
	tapCount := delayList size.
	tapDelays := Bitmap new: tapCount.
	tapGains := Bitmap new: tapCount.

	maxDelay := 0.
	1 to: tapGains size do: [:i |
		tapDelays at: i put: (delayList at: i) asInteger.
		gain := gainList at: i.
		gain >= 1.0 ifTrue: [self error: 'reverb tap gains must be under 1.0'].
		tapGains at: i put: (gain * ScaleFactor) asInteger.
		d := tapDelays at: i.
		d > maxDelay ifTrue: [maxDelay := d]].
	bufferSize := maxDelay.
	leftBuffer := SoundBuffer newMonoSampleCount: maxDelay.
	rightBuffer := SoundBuffer newMonoSampleCount: maxDelay.
	bufferIndex := 1.
