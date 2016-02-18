submorphs - buttons
fullDisplayUpdateButton
	self flag: 'tty'.
	^fullDisplayUpdateButton ifNil: 
		[fullDisplayUpdateButton := self basicButton 
						label: 'vm fullDisplayUpdate' translated; 
						actionSelector: #fullDisplayUpdate;						
						setBalloonText: 
							'Invoke fullDisplayUpdate on Simulator.' translated]