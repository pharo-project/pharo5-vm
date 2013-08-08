sample scripts
with: voiceString say: contentString
	"Speak the string
		Applescript with: 'Victoria' say: 'Hello'
	"
	^self doIt: 'say "', contentString, '" using "', voiceString, '"'
