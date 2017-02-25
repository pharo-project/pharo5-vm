objects from disk
loadConfiguration: aConfigArray
	"load the configuration but ignore the platformName - the platform name must have been handled during the creation of this vmmaker in order for it to work correctly"

	inline := aConfigArray at: 3.
	forBrowser := aConfigArray at: 4.
	"This part must be ignored --> self setPlatName: (aConfigArray at: 5)."
	"Don't go through the setters sourceDirectoryName: & platformRootDirectoryName:.
	 They do validation which only works on certain platforms and create bogus directories, etc.
	 They're broken for non-interactive use."
	sourceDirName := aConfigArray at: 6.
	platformRootDirName := aConfigArray at: 7.
	self initializeAllPlugins.
	self internal: (aConfigArray at: 1) asSortedCollection
		external:(aConfigArray at: 2) asSortedCollection.
	aConfigArray size >= 9 ifTrue: "new enough to have 64bitness flag"
		[(aConfigArray at: 8) = 8 ifTrue: [self for64BitVM].
		 (aConfigArray at: 8) = 4 ifTrue: [self for32BitVM]].
	aConfigArray size >= 11 ifTrue: "new enough to include the interpreter name"
		[self interpreterClassName: (aConfigArray at: 11)].
	self changed: #sourceDirectory;
		 changed: #reinitialize