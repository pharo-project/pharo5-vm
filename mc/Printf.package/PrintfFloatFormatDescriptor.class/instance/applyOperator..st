rendering
applyOperator: object 
	"Number is the only valid class"

	| string |
	string := self zeroPaddedStringOfBase: (('aA' includes: operator)
												ifTrue: [16]
												ifFalse: [10])
				forFloat: object asFloat.
	string := string copyFrom: 1 to: ((string indexOf: $.) + (precision = 0
						ifTrue: [-1]
						ifFalse: [self precision]) min: string size).
	(Cased includes: operator) ifTrue:
		[string := operator isLowercase
					ifTrue: [string asLowercase]
					ifFalse: [string asUppercase]].
	(space and: [object asFloat >= 0]) ifTrue:
		[string := ' ' , string].
	^(width ~= 0 and: [string size > width])
		ifTrue: [String new: width withAll: $*]
		ifFalse: [string]