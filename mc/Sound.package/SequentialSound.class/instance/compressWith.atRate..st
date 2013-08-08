composition
compressWith: codecClass atRate: aSamplingRate
	^ self copy transformSounds: [:s | s compressWith: codecClass atRate: aSamplingRate]