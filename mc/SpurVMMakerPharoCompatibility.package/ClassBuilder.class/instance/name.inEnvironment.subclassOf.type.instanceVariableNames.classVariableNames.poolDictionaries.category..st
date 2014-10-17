class definition
name: className inEnvironment: env subclassOf: newSuper type: type instanceVariableNames: instVarString classVariableNames: classVarString poolDictionaries: poolString category: category
	"Define a new class in the given environment"
	^self 
		name: className 
		inEnvironment: env 
		subclassOf: newSuper 
		type: type 
		instanceVariableNames: instVarString 
		classVariableNames: classVarString 
		poolDictionaries: poolString 
		category: category
		unsafe: false