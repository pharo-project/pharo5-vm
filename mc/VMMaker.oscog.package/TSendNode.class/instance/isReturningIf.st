testing
isReturningIf
	^(#(ifTrue:ifFalse: ifFalse:ifTrue:) includes: selector)
	   and: [arguments allSatisfy: [:arg| arg endsWithReturn]]