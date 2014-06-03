initialization
initializeWithVMSimulator: aStackInterpreterSimulator title: aString aTranscript: aTranscript
	|model|
	self flag: 'tty'. "need to get the layout right at this point. resizers and scroll bars would be nice. Layout offsets need a gimlet eye as well"
	model := StackInterpreterSimulatorMorphicModel on: aStackInterpreterSimulator title: aString transcript: aTranscript. 
	self 
		model: model;
		clipSubmorphs: true;
		setLabel: self model windowTitle;
		name: aString;
		addMorph: self newButtonRow fullFrame: self buttonRowLayoutFrame;
		addMorph: self squeakJSRow fullFrame: self squeakJSRowLayoutFrame;
		addMorph: self simulatorPanel fullFrame: self simulatorLayoutFrame;
		addMorph: self displayView fullFrame: self displayViewLayoutFrame.	
	^self		