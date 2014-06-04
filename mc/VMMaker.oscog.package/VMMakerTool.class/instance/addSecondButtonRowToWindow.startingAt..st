window construction
addSecondButtonRowToWindow: sysWin startingAt: initialVerticalOffset 
	| verticalOffset box |
	verticalOffset := initialVerticalOffset.
	"add a row of buttons to start up various actions"
	box := AlignmentMorph new vResizing: #shrinkWrap;  layoutInset: 6@3; cellInset: 6@0; wrapCentering: #center.
	box addMorph: (TextMorph new contents: 'Generate:' translated asText allBold) lock.
	box addMorphBack: (SimpleButtonMorph new target: self;
			 label: 'Entire';
			 actionSelector: #generateAll;
			 hResizing: #spaceFill;
			 setBalloonText: 'Generate the sources for the core VM and all chosen internal and external plugins').
	box addMorphBack: (SimpleButtonMorph new target: self;
			 label: 'Core+Internal';
			 actionSelector: #generateCore;
			 hResizing: #spaceFill;
			 setBalloonText: 'Generate the sources for the core vm and any internal plugins').

	box addMorphBack: (SimpleButtonMorph new target: self;
			 label: 'External Plugins';
			 actionSelector: #generateExternal;
			 hResizing: #spaceFill;
			 setBalloonText: 'Generate the sources for all external plugins').
	box addMorphBack: ((AlignmentMorph inARow: {StringMorph new contents: '64 bit VM?'. UpdatingThreePhaseButtonMorph checkBox target: self;
				 actionSelector: #toggle64BitVM;
				 getSelector: #isFor64BitVM}) layoutInset: 3;
			 cellInset: 5;
			 color: Color blue veryMuchLighter;
			 setBalloonText: 'Set to build a 64 bit VM or a 32bit VM' yourself).
	sysWin
		addMorph: box
		fullFrame: (LayoutFrame
				fractions: (0 @ 0 corner: 1 @ 0)
				offsets: (0 @ verticalOffset corner: 0 @ (verticalOffset := verticalOffset + box height - 1))).

	^verticalOffset.