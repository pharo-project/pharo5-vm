rendering
applyOperator: object 
	"Character and Number are the only valid classes"

	| number string |
	object ifNil: [^'-'].
	number := object asInteger.
	string := number printStringBase: self base.
	(radix or: [operator == $p]) ifTrue: [string := self radixString , string].
	(Cased includes: operator) ifTrue:
		[string := operator isLowercase
					ifTrue: [string asLowercase]
					ifFalse: [string asUppercase]].
	(space and: [operator == $d and: [number < 0]]) ifTrue:
		[string := ' ' , string].
	^ (width ~= 0 and: [string size > self stringLength])
		ifTrue: [String new: width withAll: $*]
		ifFalse: [string]