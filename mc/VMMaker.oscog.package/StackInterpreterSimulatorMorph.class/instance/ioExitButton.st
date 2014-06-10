submorphs - buttons
ioExitButton
	self flag: 'tty'.
	^ioExitButton ifNil: 
		[ioExitButton := self basicButton 
						label: 'vm ioExit' translated; 
						actionSelector: #ioExit;						
						setBalloonText: 
							'Invoke ioExit on Simulator.' translated]