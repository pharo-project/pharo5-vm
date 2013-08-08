testing
runWithBreakCount: theBreakCount
	"Just run, halting when byteCount is reached"
	quitBlock := [(displayView notNil
				   and: [UIManager default confirm: 'close?']) ifTrue:
					[(displayView outermostMorphThat: [:m| m isSystemWindow]) ifNotNil:
						[:topWindow| topWindow delete]].
				  ^self].
	breakCount := theBreakCount.
	self initStackPages.
	self loadInitialContext.
	self initialEnterSmalltalkExecutive