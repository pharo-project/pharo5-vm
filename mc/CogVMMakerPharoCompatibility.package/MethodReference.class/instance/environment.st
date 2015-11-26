accessing
environment
	^ environment ifNil: [
		"We will probably have MethodReferences already instantiated when this commit lands. We lazily move these over to the new, Environment aware, order of things."
		environment := Smalltalk globals].