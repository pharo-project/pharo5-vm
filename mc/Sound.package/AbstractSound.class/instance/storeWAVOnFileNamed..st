file i/o
storeWAVOnFileNamed: fileName
	"Store this sound as a 16-bit Windows WAV file of the given name."

	| f |
	f := (FileStream fileNamed: fileName) binary.
	[ self storeWAVSamplesOn: f ]
		ensure: [ f close ]