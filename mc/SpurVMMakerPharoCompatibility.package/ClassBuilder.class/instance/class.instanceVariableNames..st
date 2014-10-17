public
class: oldClass instanceVariableNames: instVarString
	"This is the basic initialization message to change the definition of
	an existing Metaclass"
	oldClass isMeta ifFalse:[^self error: oldClass name, 'is not a Metaclass'].
	^self class: oldClass instanceVariableNames: instVarString unsafe: false