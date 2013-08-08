sample scripts
sillyList
	"A silly Apple GUI demo
		Applescript sillyList
	"
	^Applescript doIt:
		'choose from list {"dogs", "cats", "lions", "pick the mouse!"}',
			'with prompt "hi there"',
			'default items {"dogs"}',
			'OK button name "DoIt!"', 
			'cancel button name "Chicken!"'