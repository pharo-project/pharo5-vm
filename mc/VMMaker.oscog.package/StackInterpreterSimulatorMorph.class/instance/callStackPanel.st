submorphs - squeakJS
callStackPanel
	"If any Morphic gurus exist, please have at it."
	^callStackPanel ifNil: 
		[callStackPanel :=  (PluggableTextMorph
				on: self model
				text: #processesAndContextStack
				accept: nil
				readSelection: nil
				menu: nil) hideScrollBarsIndefinitely.
		callStackPanel		
			color: Color transparent;
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			cellInset: 5;
			yourself].

