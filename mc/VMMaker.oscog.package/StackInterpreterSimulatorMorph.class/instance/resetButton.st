submorphs - buttons
resetButton
	^resetButton ifNil: 
		[resetButton := self basicButton 
						label: 'Reset' translated; 
						actionSelector: #reset;						
						setBalloonText: 
							'Reset running simulation.' translated]