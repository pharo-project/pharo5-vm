comparing
= anotherMethodReference 
	"Answer whether the receiver and the argument represent the 
	same object."
	^ self species == anotherMethodReference species
		and: [self classSymbol = anotherMethodReference classSymbol
		and: [self classIsMeta = anotherMethodReference classIsMeta
		and: [self methodSymbol = anotherMethodReference methodSymbol]]]