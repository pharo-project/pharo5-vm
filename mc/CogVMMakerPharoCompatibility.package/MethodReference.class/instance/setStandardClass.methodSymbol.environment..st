initialize-release
setStandardClass: aClass methodSymbol: aSelector environment: anEnvironment
	classSymbol := aClass theNonMetaClass name.
	classIsMeta := aClass isMeta.
	methodSymbol := aSelector.
	environment := anEnvironment.
	stringVersion := nil.