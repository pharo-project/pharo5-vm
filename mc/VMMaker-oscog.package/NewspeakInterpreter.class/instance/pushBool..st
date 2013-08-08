internal interpreter access
pushBool: trueOrFalse

	trueOrFalse
		ifTrue: [ self push: trueObj ]
		ifFalse: [ self push: falseObj ].