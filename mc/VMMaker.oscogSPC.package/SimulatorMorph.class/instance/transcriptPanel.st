submorphs - simulator panel
transcriptPanel
	self flag: 'tty'. "does this hybrid of PreferenceBrowser layout and Simulato openAsMorph stuff make sense?"
	^transcriptPanel ifNil: 
		[transcriptPanel := (PluggableTextMorph
				on:  self model vm transcript
				text: nil
				accept: nil
				readSelection: nil
				menu: #codePaneMenu:shifted:).
		transcriptPanel	
			name: 'transcriptPanel';	
			color: Color transparent;
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			cellInset: 5;
			yourself].
