submorphs - buttons
runButton
	self flag: 'tty'.
	^runButton ifNil: 
		[runButton := self basicButton 
						label: 'vm run' translated; 
						actionSelector: #run;						
						setBalloonText: 
							'Run Simulation.' translated]