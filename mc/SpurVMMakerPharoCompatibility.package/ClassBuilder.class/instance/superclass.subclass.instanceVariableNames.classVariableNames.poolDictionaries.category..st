public
superclass: newSuper
	subclass: t instanceVariableNames: f 
	classVariableNames: d poolDictionaries: s category: cat 
	"This is the standard initialization message for creating a new class as a 
	subclass of an existing class."
	^self 
		name: t
		inEnvironment: newSuper environment
		subclassOf: newSuper
		type: newSuper typeOfClass
		instanceVariableNames: f
		classVariableNames: d
		poolDictionaries: s
		category: cat