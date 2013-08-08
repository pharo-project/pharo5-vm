*VMMaker-C translation
asTranslationMethodOfClass: aClass
 
	^ aClass new
		setSelector: selectorOrFalse
		definingClass: encoder associationForClass value
		args: arguments
		locals: encoder tempsAndBlockArgs
		block: block
		primitive: primitive
		properties: properties
		comment: comment
