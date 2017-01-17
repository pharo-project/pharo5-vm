submorphs - buttons
returnButton
	self flag: 'tty'.
	^returnButton ifNil: 
		[returnButton := self basicButton 
						label: 'Return' translated; 
						actionSelector: #return;						
						setBalloonText: 
							'Return from what?.' translated]