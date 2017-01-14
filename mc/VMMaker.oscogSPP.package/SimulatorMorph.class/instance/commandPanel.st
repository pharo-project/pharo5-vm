submorphs - simulator panel
commandPanel
	self flag: 'tty'. "does this hybrid of PreferenceBrowser layout and Simulato openAsMorph stuff make sense?"
	^commandPanel ifNil: 
		[commandPanel :=  (PluggableTextMorph
				on: self model vm
				text: #byteCountText
				accept: nil
				readSelection: nil
				menu: #utilitiesMenu:) hideScrollBarsIndefinitely.
		commandPanel		
			color: Color transparent;
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			cellInset: 5;
			yourself].
