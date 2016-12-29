testing
run
	"Just run"
	quitBlock := [displayView ifNotNil:
				   [displayView containingWindow ifNotNil:
					[:topWindow|
					((World submorphs includes: topWindow)
					 and: [UIManager default confirm: 'close?']) ifTrue:
						[topWindow delete]]].
				  ^self close].
	self initStackPages.
	self loadInitialContext.
	self initialEnterSmalltalkExecutive