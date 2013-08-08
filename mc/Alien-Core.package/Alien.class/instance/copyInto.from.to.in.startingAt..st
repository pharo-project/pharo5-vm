primitives-accessing
copyInto: aByteObject "<Alien | indexableByteSubclass>" from: start "<Integer>" to: stop "<Integer>" in: replacement "<Alien | indexableByteSubclass>" startingAt: repStart "<Integer>" "^<self>"
	<primitive: 'primAlienReplace' error: errorCode module: 'IA32ABI'>
	^self primitiveFailed