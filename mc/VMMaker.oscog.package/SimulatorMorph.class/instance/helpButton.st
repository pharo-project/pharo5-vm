submorphs - buttons
helpButton
	^helpButton ifNil: 
		[helpButton := self basicButton 
						label: 'help' translated; 
						setBalloonText: 
							'Click here to get some hints on use of me ',
							'Panel' translated;
						actionSelector: #help]