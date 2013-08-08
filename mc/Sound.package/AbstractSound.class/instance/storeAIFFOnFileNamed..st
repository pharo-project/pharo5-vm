file i/o
storeAIFFOnFileNamed: fileName
	"Store this sound as a AIFF file of the given name."

	| f |
	f := (FileStream fileNamed: fileName) binary.
	[ self storeAIFFSamplesOn: f ]
		ensure: [ f close ]
