examples-bach fugue
unloadSampledTimbres
	"This can be done to unload those bulky sampled timbres to shrink the image. The unloaded sounds are replaced by a well-known 'unloaded sound' object to enable the unloaded sounds to be detected when the process is reversed."
	"AbstractSound unloadSampledTimbres"

	Sounds keysAndValuesDo: [:soundName : sound|
		((sound isKindOf: SampledInstrument) or:
		 [sound isKindOf: LoopedSampledSound]) ifTrue: [
			Sounds at: soundName put: self unloadedSound]].
	self updateScorePlayers.
	Smalltalk garbageCollect.
