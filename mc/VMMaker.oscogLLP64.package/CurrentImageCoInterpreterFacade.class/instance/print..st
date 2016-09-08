printing
print: it
	it isString ifTrue: [coInterpreter transcript nextPutAll: it] ifFalse: [it printOn: coInterpreter transcript]