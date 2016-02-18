version identification
versionString
	"Answer a string containing the version string for this plugin. Handle MNU
	errors, which can occur if class InterpreterPlugin has been removed from
	the system.

	Important: When this method is changed, the class side method must also be
	changed to match."

	"2.0 supports 64bit code base"

	| version |
	<returnTypeC: 'char *'>
	<var: 'version' declareC: 'static char version[]= "2.2.6"'>
	^ self cCode: 'version' inSmalltalk: ['2.2.6']

