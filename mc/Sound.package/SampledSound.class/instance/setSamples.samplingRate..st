initialization
setSamples: anArray samplingRate: rate
	"Set my samples array to the given array with the given nominal sampling rate. Altering the rate parameter allows the sampled sound to be played back at different pitches."
	"Note: There are two ways to use sampled sound: (a) you can play them through once (supported by this method) or (b) you can make them the default waveform with which to play a musical score (supported by the class method defaultSampleTable:)."
	"Assume: anArray is either a SoundBuffer or a collection of signed 16-bit sample values."
	"(SampledSound
		samples: SampledSound coffeeCupClink
		samplingRate: 5000) play"

	"copy the array into a SoundBuffer if necessary"
	anArray class isWords
		ifTrue: [samples := anArray]
		ifFalse: [samples := SoundBuffer fromArray: anArray].

	samplesSize := samples size.
	samplesSize >= SmallInteger maxVal ifTrue: [  "this is unlikely..."
		self error: 'sample count must be under ',  SmallInteger maxVal printString].
	originalSamplingRate := rate.
	initialCount := (samplesSize * self samplingRate) // originalSamplingRate.
	self loudness: 1.0.
	self reset.
