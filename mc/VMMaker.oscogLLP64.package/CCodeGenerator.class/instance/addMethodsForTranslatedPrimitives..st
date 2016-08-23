public
addMethodsForTranslatedPrimitives: classAndSelectorList 
	| verbose |
	verbose := false.
	classAndSelectorList do:
		[:classAndSelector | | aClass selector meth |
		aClass := Smalltalk at: classAndSelector first.
		selector := classAndSelector last.
		self addAllClassVarsFor: aClass.

		"compile the method source and convert to a suitable translation method.
		 find the method in either the class or the metaclass"
		meth := self
					compileToTMethodSelector: selector
					in: ((aClass includesSelector: selector)
							ifTrue: [aClass]
							ifFalse: [aClass class]).
		meth primitive > 0 ifTrue:
			[meth preparePrimitiveName].
		meth replaceSizeMessages.
		self addMethod: meth].

	self prepareMethods