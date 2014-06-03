submorphs - buttons
hackButton
	self flag: 'tty'.
	^hackButton ifNil: 
		[hackButton := self basicButton 
						label: 'Display ImageMorph Bounds' translated; 
						actionSelector: #hack;						
						setBalloonText: 
							'tty needs a hack button.' translated]