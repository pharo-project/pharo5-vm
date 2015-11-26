initialize-release
setStandardClass: aClass methodSymbol: methodSym

	classSymbol := aClass theNonMetaClass name.
	classIsMeta := aClass isMeta.
	methodSymbol := methodSym.
	stringVersion := nil.