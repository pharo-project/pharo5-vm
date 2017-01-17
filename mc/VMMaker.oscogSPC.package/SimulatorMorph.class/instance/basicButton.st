submorphs - buttons
basicButton
	| button |
	button := SimpleButtonMorph new.
	button
		borderWidth: 2;
		borderColor: #raised;
		on: #mouseEnter send: #value to: [button borderColor: self paneColor];
		on: #mouseLeave send: #value to: [button borderColor: #raised];
		vResizing: #spaceFill;
		useRoundedCorners;
		clipSubmorphs: true;
		color: self paneColor muchLighter;
		target: self model.
	^button