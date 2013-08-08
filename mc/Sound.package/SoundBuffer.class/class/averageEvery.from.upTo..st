instance creation
averageEvery: nSamples from: anotherBuffer upTo: inCount

	^(self newMonoSampleCount: inCount // nSamples)
		averageEvery: nSamples 
		from: anotherBuffer 
		upTo: inCount