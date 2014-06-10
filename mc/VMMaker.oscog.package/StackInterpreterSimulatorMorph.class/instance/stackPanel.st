submorphs - squeakJS
stackPanel
	"If any Morphic gurus exist, please have at it."
	^stackPanel ifNil: 
		[stackPanel :=  (PluggableTextMorph
				on: self model
				text: #currentContextStack
				accept: nil
				readSelection: nil
				menu: nil) hideScrollBarsIndefinitely.
		stackPanel		
			color: Color transparent;
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			cellInset: 5;
			yourself].

