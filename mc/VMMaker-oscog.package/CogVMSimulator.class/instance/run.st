testing
run
	"Just run"
	quitBlock := [| topWindow |
				  
				   (displayView notNil
				   and: [topWindow := displayView outermostMorphThat:
									[:m| m isSystemWindow and: [World submorphs includes: m]].
						topWindow notNil
				   and: [UIManager default confirm: 'close?']]) ifTrue:
					[topWindow delete].
				  ^self].
	self initStackPages.
	self loadInitialContext.
	self initialEnterSmalltalkExecutive