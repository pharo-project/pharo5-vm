reading
readFromFile: fileName
	"Read the AIFF file of the given name."
	"AIFFFileReader new readFromFile: 'test.aiff'"

	self readFromFile: fileName
		mergeIfStereo: false
		skipDataChunk: false.
