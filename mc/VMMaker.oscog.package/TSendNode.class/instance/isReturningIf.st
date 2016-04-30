testing
isReturningIf
	^(#(ifTrue:ifFalse: ifFalse:ifTrue: ifNil:ifNotNil: ifNotNil:ifNil:) includes: selector)
	   and: [arguments allSatisfy: [:arg| arg endsWithReturn]]