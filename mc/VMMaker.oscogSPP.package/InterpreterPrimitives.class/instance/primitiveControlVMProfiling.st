process primitives
primitiveControlVMProfiling
	"Primitive. Start or stop the VM profiler.  The first argument is a boolean
	 to switch profiling on or off.  The second argument is an integer or nil.
	 If an integer it determines the maximum number of samples in the VM's
	 sample buffer. Answer the current number of samples in the buffer."
	| onOffBar bufferSize numSamples |
	argumentCount ~= 2 ifTrue:
		[^self primitiveFail].
	(onOffBar := self stackValue: 1) = objectMemory trueObject
		ifTrue: [onOffBar := 1]
		ifFalse:
			[onOffBar = objectMemory falseObject
				ifTrue: [onOffBar := 0]
				ifFalse: [^self primitiveFail]].
	(bufferSize := self stackTop) = objectMemory nilObject
		ifTrue: [bufferSize := 0]
		ifFalse:
			[((objectMemory isIntegerObject: bufferSize)
			  and: [(bufferSize := objectMemory integerValueOf: bufferSize) > 0]) ifFalse:
				[^self primitiveFail]].
	numSamples := self cCode: 'ioControlNewProfile(onOffBar,bufferSize)'.
	self pop: 3 thenPushInteger: numSamples