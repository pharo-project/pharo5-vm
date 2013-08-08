reading
readFromFile: fileName mergeIfStereo: mergeFlag skipDataChunk: skipDataFlag
	"Read the AIFF file of the given name. See comment in readFromStream:mergeIfStereo:skipDataChunk:."
	"AIFFFileReader new readFromFile: 'test.aiff' mergeIfStereo: false skipDataChunk: true"

	| f |
	f := (FileStream readOnlyFileNamed: fileName) binary.
	[ self readFromStream: f mergeIfStereo: mergeFlag skipDataChunk: skipDataFlag]
       ensure: [ f close]
