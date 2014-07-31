process primitives
primitiveVMProfileSamplesInto
	"Primitive.
	 0 args: Answer whether the VM Profiler is running or not.
	 1 arg:	Copy the sample data into the supplied argument, which must be a Bitmap
			of suitable size. Answer the number of samples copied into the buffer."
	| sampleBuffer sampleBufferAddress running bufferSize numSamples |
	<var: #bufferSize type: #long>
	<var: #sampleBufferAddress type: #'unsigned long *'>
	self cCode: 'ioNewProfileStatus(&running,&bufferSize)'
		inSmalltalk: [running := false. bufferSize := 0].
	argumentCount = 0 ifTrue:
		[^self pop: 1 thenPushBool: running].
	self success: argumentCount = 1.
	successFlag ifTrue:
		[sampleBuffer := self stackObjectValue: 0.
		 self assertClassOf: sampleBuffer is: (self splObj: ClassBitmap).
		 self success: (self numSlotsOf: sampleBuffer) >= bufferSize].
	successFlag ifFalse:
		[^nil].
	sampleBufferAddress := self firstFixedField: sampleBuffer.
	numSamples := self cCode: 'ioNewProfileSamplesInto(sampleBufferAddress)'
						inSmalltalk: [sampleBufferAddress := sampleBufferAddress].
	self pop: argumentCount + 1 thenPushInteger: numSamples