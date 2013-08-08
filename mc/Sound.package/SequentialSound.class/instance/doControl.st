sound generation
doControl

	super doControl.
	currentIndex > 0
		ifTrue: [(sounds at: currentIndex) doControl].
