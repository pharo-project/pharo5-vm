instruction decoding
send: selector super: supered numArgs: numArgs
	numArgs timesRepeat: [currentContext pop].
	currentContext pop ifNotNil:
		[:top|
		((top isArray and: [top size = 2 and: [top first == #inst]])
		 or: [top == #self]) ifTrue:
			[(sends at: top ifAbsentPut: [Set new]) add: selector]].
	currentContext push: 'send ', selector