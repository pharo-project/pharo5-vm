submorphs - buttons
stepButton
	self flag: 'tty'.
	^stepButton ifNil: 
		[stepButton := self basicButton 
						label: 'Step' translated; 
						actionSelector: #step;						
						setBalloonText: 
							'Step Into.' translated]