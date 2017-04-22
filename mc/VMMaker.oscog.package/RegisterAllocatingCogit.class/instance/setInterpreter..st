initialization
setInterpreter: aCoInterpreter
	"Override to elide optStatus which shoudl be unused since simSelf has a liveRegister
	 and hence more elegantly accomplishes the same purpose."
	<doNotGenerate>
	super setInterpreter: aCoInterpreter.
	optStatus := nil