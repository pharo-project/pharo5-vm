coffee cup clink
coffeeCupClink
	"Return the samples array for the sound of a spoon being tapped against a coffee cup."

	CoffeeCupClink ifNil: [self initializeCoffeeCupClink].
	^ CoffeeCupClink
