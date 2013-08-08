private
doAsOSAID: aCodeBlock onErrorDo: anErrorBlock
	"Answer the result of performing aBlock on my compiledScript, converted to OSAID form.  As a side-effect, update compiledScript to conform to any changes that may have occurred inside the Applescript scripting component."

	| anOSAID result |
	anOSAID := compiledScript asAEDesc asOSAIDThenDisposeAEDescWith: ApplescriptGeneric.
	result := aCodeBlock value: anOSAID.
	compiledScript := (anOSAID asCompiledApplescriptWith: ApplescriptGeneric)
						ifNil: [compiledScript].
	anOSAID disposeWith: ApplescriptGeneric.
	^result ifNil: [anErrorBlock value]