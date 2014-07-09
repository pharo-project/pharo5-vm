covering
uncoverMethod: aMethod
	| coverage |
	coverage := aMethod propertyValueAt: #coverage.
	coverage ifNil: [^self].
	coverage keysAndValuesDo:
		[:pc :bytecode|
		aMethod at: pc put: bytecode].
	aMethod removeProperty: #coverage.
	(aMethod penultimateLiteral isMethodProperties
	 and: [aMethod penultimateLiteral isEmpty]) ifTrue:
		[aMethod penultimateLiteral: aMethod selector]