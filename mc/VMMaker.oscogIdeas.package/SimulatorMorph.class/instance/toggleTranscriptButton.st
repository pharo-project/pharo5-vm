submorphs - buttons
toggleTranscriptButton
	"tty I dont like this. I have diabled the button"
	self flag: 'tty'.
	^toggleTranscriptButton ifNil: 
		[toggleTranscriptButton := self basicButton 
						label: 'Toggle Transcript' translated; 
						actionSelector: #toggleTranscript;						
						setBalloonText: 
							'Use External Transcript Instead of Internal.' translated]