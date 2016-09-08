test tight coupling
testStackInterpreterSimulatorDisplayViewAccess
	"There is tight coupling between the morph,model and vm simulator on the simulators displayView variable
	 this test makes sure it is accesible and is an ImageMorph."
	
self assert: ((SystemNavigation allImplementorsOf: #displayView localTo: StackInterpreterSimulator) size = 1).
self assert: ((SystemNavigation allImplementorsOf: #displayView: localTo: StackInterpreterSimulator)size = 1).

