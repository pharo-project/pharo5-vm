sound library
soundNamed: aString
	"Answer the sound of the given name, or, if there is no sound of that name, put up an informer so stating, and answer nil"

	"(SampledSound soundNamed: 'shutterClick') play"

	^ self soundNamed: aString ifAbsent: [Beeper default]