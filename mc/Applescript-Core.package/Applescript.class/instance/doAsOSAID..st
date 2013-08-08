private
doAsOSAID: aBlock
	"Answer the result of performing aBlock on my compiledScript, converted to OSAID form.  As a side-effect, update compiledScript to conform to any changes that may have occurred inside the Applescript scripting component."

	^self doAsOSAID: aBlock onErrorDo:
		[ApplescriptError 
			syntaxErrorFor: source 
			withComponent: ApplescriptGeneric]