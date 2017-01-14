initialization
initializeWithVMSimulator: aStackInterpreterSimulator title: aString aTranscript: aTranscript
	self flag: 'tty'. "need to get the layout right at this point. resizers and scroll bars would be nice. Layout offsets need a gimlet eye as well"
	self 
		model: (SimulatorMorphicModel on: aStackInterpreterSimulator title: aString transcript: aTranscript);
		clipSubmorphs: true;
		setLabel: self model windowTitle;
		name: aString;
		addMorph: self newButtonRow fullFrame: self buttonRowLayoutFrame;
		addMorph: self squeakJSRow fullFrame: self squeakJSRowLayoutFrame;
		addMorph: self simulatorPanel fullFrame: self simulatorLayoutFrame;
		addMorph: self displayView fullFrame: self displayViewLayoutFrame.	
	^self