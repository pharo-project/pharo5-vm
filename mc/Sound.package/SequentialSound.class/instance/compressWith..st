composition
compressWith: codecClass
	^ self copy transformSounds: [:s | s compressWith: codecClass]