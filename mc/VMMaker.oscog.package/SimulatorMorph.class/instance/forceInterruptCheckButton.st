submorphs - buttons
forceInterruptCheckButton
	self flag: 'tty'.
	^forceInterruptCheckButton ifNil: 
		[forceInterruptCheckButton := self basicButton 
						label: 'vm forceInterruptCheck' translated; 
						actionSelector: #forceInterruptCheck;						
						setBalloonText: 
							'Invoke forceInterruptCheck on Simulator.' translated]