window construction
entryRowWithLabel: label balloonText: balloonText getFieldText: getTextSelector setFieldText: setTextSelector buttonLabel: buttonLabel buttonAction: buttonAction buttonBalloonText: buttonBalloonText 
	| row lWidth |
	lWidth := TextStyle defaultFont pixelSize * 11.
	row := Morph new color: Color transparent;
				 hResizing: #spaceFill;
				 vResizing: #spaceFill;
				 extent: 550 @ 40;
				 layoutPolicy: ProportionalLayout new;
				 borderWidth: 2;
				 setBalloonText: balloonText translated;
				 yourself.
	row
		addMorph: (TextMorph new contents: label translated asText allBold) lock
		fullFrame: (LayoutFrame
				fractions: (0 @ 0 corner: 0 @ 1)
				offsets: (3 @ 3 corner: lWidth @ -3)).
	row
		addMorph: ((PluggableTextMorph
				on: self
				text: getTextSelector
				accept: setTextSelector) hideVScrollBarIndefinitely: true;
				 acceptOnCR: true)
		fullFrame: (LayoutFrame
				fractions: (0 @ 0 corner: 1 @ 1)
				offsets: (lWidth + 10 @ 0 corner: (lWidth / 1.8 + 10) negated @ 0)).
	buttonAction
		ifNotNil: [row
				addMorph: (SimpleButtonMorph new target: self;
						 label: buttonLabel translated;
						 actionSelector: buttonAction;
						 hResizing: #spaceFill;
						 setBalloonText: buttonBalloonText translated)
				fullFrame: (LayoutFrame
						fractions: (1 @ 0 corner: 1 @ 1)
						offsets: ((lWidth / 1.8 + 5) negated @ 3 corner: -5 @ -3))].
	^ row