instance creation
fromAIFFFileNamed: fileName mergeIfStereo: mergeFlag
	"Initialize this sound from the data in the given AIFF file. If mergeFlag is true and the file is stereo, its left and right channels are mixed together to produce a mono sampled sound."

	| aiffFileReader |
	aiffFileReader := AIFFFileReader new.
	aiffFileReader readFromFile: fileName
		mergeIfStereo: mergeFlag
		skipDataChunk: false.
	self new fromAIFFFileReader: aiffFileReader mergeIfStereo: mergeFlag