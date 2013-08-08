class initialization
ensureNotifiedAtStartupAfter: anotherClass
	"Support routine for putting Alien classes in the start-up list."
	anotherClass ensureNotifiedAtStartup.
	Smalltalk addToStartUpList: self after: anotherClass