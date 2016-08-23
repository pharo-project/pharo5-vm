generate sources
configurationGeneratorNameOrNil
	"Search the sender chain for the first method in VMMaker class protocol configurations, and answer it if found,
	 otherwise answer nil.  This allows us to name the configuration being generated."
	^thisContext findContextSuchThat:
		[:ctxt|
		 ctxt receiver == VMMaker
		 and: [ctxt method methodReference category = #configurations]]