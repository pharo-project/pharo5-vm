submorphs - buttons
sendButton
	self flag: 'tty'.
	^sendButton ifNil: 
		[sendButton := self basicButton 
						label: 'Send' translated; 
						actionSelector: #send;						
						setBalloonText: 
							'Send what exactly?.' translated]