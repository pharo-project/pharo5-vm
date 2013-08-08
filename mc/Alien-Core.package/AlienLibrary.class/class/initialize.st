initialization
initialize
	"self initialize"
	
	super initialize.
	Smalltalk removeFromShutDownList: self.
	Smalltalk addToStartUpList: self.
	