disk i/o
objectForDataStream: refStrm
    "Answer an object to store on a data stream, a copy of myself whose SampleBuffers have been converted into ByteArrays."

	refStrm replace: leftSamples with: leftSamples asByteArray.
	refStrm replace: rightSamples with: rightSamples asByteArray.
	"substitution will be made in DataStream nextPut:"
	^ self
