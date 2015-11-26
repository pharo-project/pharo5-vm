testing
isValid
	"Answer whether the receiver represents a current selector or Comment"

	| aClass |
	methodSymbol isDoIt ifTrue: [^ false].
	(aClass := self actualClass) ifNil: [^ false].
	^ (aClass includesSelector: methodSymbol) or:
		[methodSymbol == #Comment]