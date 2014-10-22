printing
stringForSelector: selector numArgs: numArgs
	^(selector isSymbol and: [selector numArgs = numArgs])
		ifTrue: [selector]
		ifFalse: [selector printString
				, (numArgs = 1
					ifTrue: [' (1 arg)']
					ifFalse: [' (', numArgs printString, ' args)'])]