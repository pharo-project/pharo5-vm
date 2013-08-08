sample scripts
sillyButtons
	"A silly Apple GUI demo
		Applescript sillyButtons
	"
	^self doIt: '
		display dialog "The Mouse that Roars!" ',
			'buttons {"One", "Two", "Three"} default button "One"'
