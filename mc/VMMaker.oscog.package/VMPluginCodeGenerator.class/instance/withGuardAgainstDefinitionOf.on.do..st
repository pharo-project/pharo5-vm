C translation
withGuardAgainstDefinitionOf: selector on: aStream do: aBlock
	"Evaluate aBlock, surrounded by a define if selector is defined as a macro (i.e. by preDeclareInterpreterProxyOn:"
	(self selectorsThatMayBeGeneratedAsMacros includes: selector) ifFalse:
		[^aBlock value].
	aStream nextPutAll: '#if !defined('; nextPutAll: (self cFunctionNameFor: selector); nextPut: $); cr.
	aBlock value.
	aStream nextPutAll: '#endif'; cr