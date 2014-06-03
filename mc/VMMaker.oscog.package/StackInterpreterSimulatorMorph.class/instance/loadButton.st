submorphs - buttons
loadButton
	^loadButton ifNil: 
		[loadButton := self basicButton 
						label: 'Load Image' translated; 
						actionSelector: #loadImage;						
						setBalloonText: 
							'Select an image to load.' translated]