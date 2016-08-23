submorphs - simulator panel
simulatorPanel
	"standard controls from StackInterpreterSimulator >> openAsMorph"
	^BorderedMorph new
		color: Color transparent;
		layoutInset: 10;
		cellInset: 10;
		layoutPolicy: TableLayout new;
		listDirection: #topToBottom;
		listCentering: #topLeft;
		cellPositioning: #topLeft;
		on: #mouseEnter send: #paneTransition: to: self;
		on: #mouseLeave send: #paneTransition: to: self;		
		addMorphBack: self transcriptPanel;
		addMorphBack: self commandPanel;
		yourself.