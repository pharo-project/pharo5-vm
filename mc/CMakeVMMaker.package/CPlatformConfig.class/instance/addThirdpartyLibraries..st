thirdparty libs
addThirdpartyLibraries: aCollection 
	aCollection do: [ :each | self addThirdpartyLibrary: each ]