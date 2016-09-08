submorphs - simulator display view
displayView
	"The VM SImulator draws directly on an imageMorph named displayView
	  displayView is housed on a Form named displayForm
	   displayForm is initialized in StackInterpreterSimulator >> initialize.
	  see StackInterpreterSimulator >>openAsMorph for original constructs."
	^displayView ifNil: 
		[displayView :=  SimulatorImageMorph new image: model vm displayForm. 
		self model displayView: displayView.					
		self model morph: displayView. "<-- N.B.. morph bounds are used to filter events in the model. tty"
	      displayView activeHand addEventListener: self model.		

 		displayView		
			color: Color transparent;
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			cellInset: 5;
			yourself]