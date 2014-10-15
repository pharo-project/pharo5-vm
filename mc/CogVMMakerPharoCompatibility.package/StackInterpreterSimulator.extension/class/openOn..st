*CogVMMakerPharoCompatibility
openOn: imageName
	| sim |
	InterpreterStackPage initialize.
	StackInterpreterSimulator initializeWithOptions: Dictionary new.
	sim :=  StackInterpreterSimulator new.
	sim openOn: imageName. 
	sim openAsMorph.
	"sim inspect."
	1 to: 500 do: [:i |
	    World doOneCycleNow.
	    sim runForNBytes: 100000 ].