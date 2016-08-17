compile abstract instructions
compileFrameBuild
	"Build a frame for a CogMethod activation.  See CoInterpreter class>>initializeFrameIndices.
	 Override to push the register receiver and register arguments, if any."
	self cppIf: IMMUTABILITY ifTrue: 
		[useTwoPaths ifTrue: 
			[self compileTwoPathFrameBuild.
		 	^self]].
	needsFrame ifFalse:
		[useTwoPaths ifTrue: 
			[self compileTwoPathFramelessInit].
		 self initSimStackForFramelessMethod: initialPC.
		 ^self].
	self deny: useTwoPaths.
	self genPushRegisterArgs.
	super compileFrameBuild.
	self initSimStackForFramefulMethod: initialPC