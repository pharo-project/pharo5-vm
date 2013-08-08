private
readInstrumentChunk: chunkSize

	| midiKey detune lowNote highNote lowVelocity highVelocity
	  sustainMode sustainStartID sustainEndID
	  releaseMode releaseStartID releaseEndID |

	midiKey := in next.
	detune := in next.
	lowNote := in next.
	highNote := in next.
	lowVelocity := in next.
	highVelocity := in next.
	gain := in nextNumber: 2.
	sustainMode := in nextNumber: 2.
	sustainStartID := in nextNumber: 2.
	sustainEndID := in nextNumber: 2.
	releaseMode := in nextNumber: 2.
	releaseStartID := in nextNumber: 2.
	releaseEndID := in nextNumber: 2.
	isLooped := sustainMode = 1.
	(isLooped and: [markers notNil]) ifTrue: [
		((markers first last > frameCount) or:
		 [markers last last > frameCount]) ifTrue: [
			"bad loop data; some sample CD files claim to be looped but aren't"
			isLooped := false]].
	pitch := self pitchForKey: midiKey.
