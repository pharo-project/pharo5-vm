submorphs - squeakJS
squeakJSRow
	"row fo SqueakJS context, stack and call-stack panels"
	^BorderedMorph new
		color: Color blue;
		cellInset: 2;
		layoutInset: 2;
		layoutPolicy: TableLayout new;
		listDirection: #leftToRight;
		listCentering: #topLeft;
		cellPositioning: #topLeft;
		on: #mouseEnter send: #paneTransition: to: self;
		on: #mouseLeave send: #paneTransition: to: self;
		addMorphBack: self callStackPanel;
		addMorphBack: self contextPanel;
		addMorphBack: self stackPanel;		
		yourself.