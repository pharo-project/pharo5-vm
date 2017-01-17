process primitives
primitiveVMProfileSamplesInto
	"Primitive.
	 0 args: Answer whether the VM Profiler is running or not.
	 1 arg:	Copy the sample data into the supplied argument, which must be a Bitmap
			of suitable size. Answer the number of samples copied into the buffer."
	| sampleBuffer running bufferSize numSamples |
	<var: #bufferSize type: #long>
	self ioNewProfile: (self addressOf: running put: [:v| running := v])
		Status: (self addressOf: bufferSize put: [:v| bufferSize := v]).
	argumentCount = 0 ifTrue:
		[^self pop: 1 thenPushBool: running].
	argumentCount = 1 ifFalse:
		[^self primitiveFailFor: PrimErrBadNumArgs].
	sampleBuffer := self stackValue: 0.
	((objectMemory isNonImmediate: sampleBuffer)
	 and: [(objectMemory isPureBitsNonImm: sampleBuffer)
	 and: [(objectMemory numBytesOf: sampleBuffer) >= (bufferSize * objectMemory wordSize)]]) ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	numSamples := self ioNewProfileSamplesInto: (objectMemory firstFixedField: sampleBuffer).
	self pop: argumentCount + 1 thenPushInteger: numSamples