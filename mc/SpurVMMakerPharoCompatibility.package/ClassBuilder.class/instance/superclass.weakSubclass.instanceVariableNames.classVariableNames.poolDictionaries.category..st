public
superclass: aClass
	weakSubclass: t instanceVariableNames: f 
	classVariableNames: d poolDictionaries: s category: cat
	"This is the standard initialization message for creating a new class as a 
	subclass of an existing class (the receiver) in which the subclass is to 
	have weak indexable pointer variables."
	aClass isBits 
		ifTrue: [^self error: 'cannot make a pointer subclass of a class with non-pointer fields'].
	^self 
		name: t
		inEnvironment: aClass environment
		subclassOf: aClass
		type: #weak
		instanceVariableNames: f
		classVariableNames: d
		poolDictionaries: s
		category: cat