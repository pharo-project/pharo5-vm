public
superclass: aClass
	variableWordSubclass: t instanceVariableNames: f 
	classVariableNames: d poolDictionaries: s category: cat
	"This is the standard initialization message for creating a new class as a 
	subclass of an existing class in which the subclass is to 
	have indexable word-sized nonpointer variables."
	(aClass instSize > 0)
		ifTrue: [^self error: 'cannot make a word subclass of a class with named fields'].
	(aClass isVariable and: [aClass isBytes])
		ifTrue: [^self error: 'cannot make a word subclass of a class with byte fields'].
	(aClass isVariable and: [aClass isPointers])
		ifTrue: [^self error: 'cannot make a word subclass of a class with pointer fields'].

	^self 
		name: t
		inEnvironment: aClass environment
		subclassOf: aClass
		type: #words
		instanceVariableNames: f
		classVariableNames: d
		poolDictionaries: s
		category: cat