submorphs - buttons
newButtonRow
	^BorderedMorph new
		color: Color transparent;
		cellInset: 2;
		layoutInset: 2;
		layoutPolicy: TableLayout new;
		listDirection: #leftToRight;
		listCentering: #topLeft;
		cellPositioning: #topLeft;
		on: #mouseEnter send: #paneTransition: to: self;
		on: #mouseLeave send: #paneTransition: to: self;
		addMorphBack: self hackButton;
		addMorphBack: self newSeparator;

"		addMorphBack: self resetButton;
		addMorphBack: self newSeparator;
		addMorphBack: self forceInterruptCheckButton;
		addMorphBack: self newSeparator;
		addMorphBack: self fullDisplayUpdateButton;
		addMorphBack: self newSeparator;
		addMorphBack: self toggleTranscriptButton;"  
		addMorphBack: self runButton;				
		addMorphBack: self newSeparator; 
		addMorphBack: self ioExitButton;
		addMorphBack: self newTransparentFiller;		
		addMorphBack: self stepButton;
		addMorphBack: self newSeparator;		
		addMorphBack: self overButton;
		addMorphBack: self newSeparator;
		addMorphBack: self newSeparator;		
		addMorphBack: self sendButton;
		addMorphBack: self newSeparator;		
		addMorphBack: self returnButton;		
		addMorphBack: self newTransparentFiller;
"		addMorphBack: self loadButton;
		addMorphBack: self newSeparator;				
		addMorphBack: self optionsButton;     too complex to implement now. See StackInterpreterSimulator class comment for examples"										
		addMorphBack: self newTransparentFiller;
		addMorphBack: self helpButton;
		yourself.