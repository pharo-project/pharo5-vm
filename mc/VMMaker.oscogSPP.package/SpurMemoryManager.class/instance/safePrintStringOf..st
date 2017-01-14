debug printing
safePrintStringOf: oop
	| target |
	(self isOopForwarded: oop)
		ifTrue: [target := self followForwarded: oop]
		ifFalse: [target := oop].
	^coInterpreter printStringOf: target