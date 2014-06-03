class initialization
initialize
	SavedState := WeakIdentityKeyDictionary new.
	Smalltalk
		addToStartUpList: self;
		addToShutDownList: self