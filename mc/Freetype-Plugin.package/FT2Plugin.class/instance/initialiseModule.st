initialize
initialiseModule
	self export: true.
	library := nil.
	
	" not implemented?? commented out because of compilation errors 
	
	self ifDefined: 'macintoshSqueak' then: [
		self fetchPreferences.
	].
	"
	
	errorCode := self cCode: 'FT_Init_FreeType(&library)' inSmalltalk: [0].
	^ errorCode == 0.