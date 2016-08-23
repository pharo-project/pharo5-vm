accessing
methodNeedsLargeContext: aMethodOop 
	^(self objectForOop: aMethodOop) frameSize > CompiledMethod smallFrameSize