playing
playSoundNamed: soundName ifAbsentReadFrom: aifFileName

	SoundService soundEnabled ifTrue: [
		(SampledSound soundNames includes: soundName) ifFalse: [
			aifFileName asFileReference exists ifTrue: [
				SampledSound
					addLibrarySoundNamed: soundName
					fromAIFFfileNamed: aifFileName]].
		(SampledSound soundNames includes: soundName) ifTrue: [
			SampledSound playSoundNamed: soundName]]