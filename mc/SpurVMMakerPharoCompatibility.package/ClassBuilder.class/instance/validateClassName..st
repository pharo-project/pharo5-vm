validation
validateClassName: aString
	"Validate the new class name"
	| allowed |
	aString isSymbol
		ifFalse: [ ^ false ].
	allowed := ($0 to: $9), {$_}, ($A to: $Z), ($a to: $z).
	(aString detect: [:c | (allowed includes: c) not] ifNone: [ ])
		ifNotNil: [ :c | self error: 'Invalid character: ''', c printString, ''''.
			^ false].
	aString first canBeGlobalVarInitial ifFalse:[
		self error: 'Class names must be capitalized'.
		^false].
	environ at: aString ifPresent:[:old|
		(old isKindOf: Behavior) ifFalse:[
			self notify: aString, ' already exists!\Proceed will store over it.' withCRs]].
	^ true