file i/o
storeSunAudioOnFileNamed: fileName
	"Store this sound as an uncompressed Sun audio file of the given name."

	| f |
	f := (FileStream fileNamed: fileName) binary.
	[ self storeSunAudioSamplesOn: f]
		ensure: [ f close ]