window construction
addTopButtonRowToWindow: sysWin
	| verticalOffset box |
	verticalOffset := 0.

	"add a row of buttons to start up various actions"
	box := AlignmentMorph new vResizing: #shrinkWrap;
				 layoutInset: 6 @ 3;
				 cellInset: 6 @ 0;
				 wrapCentering: #center.
	box addMorphBack: (SimpleButtonMorph new target: self;
			 label: 'Help';
			 actionSelector: #helpText;
			 hResizing: #spaceFill;
			 setBalloonText: 'Open the help window').
	box addMorphBack: (TextMorph new contents: 'Configuration File:' translated asText allBold) lock.	
	box addMorphBack: (SimpleButtonMorph new target: self;
			 label: 'Load';
			 actionSelector: #loadConfig;
			 hResizing: #spaceFill;
			 setBalloonText: 'Load a previously saved configuration').
	box addMorphBack: (SimpleButtonMorph new target: self;
			 label: 'Save';
			 actionSelector: #saveConfig;
			 hResizing: #spaceFill;
			 setBalloonText: 'Save the current configuration').
	sysWin
		addMorph: box
		fullFrame: (LayoutFrame
				fractions: (0 @ 0 corner: 1 @ 0)
				offsets: (0 @ verticalOffset corner: 0 @ (verticalOffset := verticalOffset + box height - 1))).
	^ verticalOffset