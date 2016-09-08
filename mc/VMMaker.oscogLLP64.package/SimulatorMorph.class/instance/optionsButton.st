submorphs - buttons
optionsButton
	^optionsButton ifNil: 
		[optionsButton := self basicButton 
						label: 'VM Options' translated; 
						actionSelector: #options;						
						setBalloonText: 
							'VM Options.' translated]