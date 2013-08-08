car motor example
carMotorSound: speed
	"Return a repeating sound for the sound of a car engine running at the given speed."
	"(RepeatingSound carMotorSound: 2.0) play"

	CarMotorSamples ifNil: [self initializeCarMotor].
	^ RepeatingSound repeatForever:
		((LoopedSampledSound
			unloopedSamples: CarMotorSamples
			pitch: 20.0
			samplingRate: 22050)
				setPitch: speed dur: 100.0 loudness: 1.0)
