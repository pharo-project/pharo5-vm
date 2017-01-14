plugin lists
plugins: aCollection do: aBlock 
	"for each class in aCollection that should be a plugin, evaluate aBlock"
	aCollection do: [:sym | (Smalltalk hasClassNamed: sym)
			ifTrue: [aBlock value: (Smalltalk classNamed: sym)]
			ifFalse:["Another place to raise a sensible error to the UI"
				self couldNotFindPluginClass: sym]]