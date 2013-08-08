printing
printOn: aStream

	aStream nextPutAll: 'an Applescript('.
	self isCompiledScript ifTrue: [aStream nextPutAll: 'script '].
	self isScriptContext ifTrue: [aStream nextPutAll: 'context '].
	aStream 
		nextPutAll: compiledScript size asString;
		nextPutAll: ' bytes)'
