interpreting
scriptingName
"Answer the name of my generic scripting component"

	|aeDesc result |
	aeDesc := AEDesc new.
	result := self primOSAScriptingComponentNameTo: aeDesc.
	result isZero ifFalse: [^nil].
	^aeDesc asStringThenDispose.
