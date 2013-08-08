sound library
soundNamed: soundName ifAbsent: aBlock

	^ Sounds at: soundName ifAbsent: aBlock
