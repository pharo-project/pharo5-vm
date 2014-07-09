class definition
anonymousSubclassOf: newSuper
	"Create an annonimous subclass of the given superclass."

	^ self
		newSubclassOf: newSuper
		type: newSuper typeOfClass
		instanceVariables: ''
		from: nil