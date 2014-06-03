utilities
compileToTMethodSelector: selector in: aClass
	"Compile a method to a TMethod. Override to eagerly record declarations etc
	 that happen in a later phase in the main VM's CCodeGenerator."

	| m |
	m := (Compiler new
			parse: (aClass sourceCodeAt: selector)
			in: aClass
			notifying: nil)
				asTranslationMethodOfClass: self translationMethodClass.
	m removeFinalSelfReturnIn: self.
	m recordDeclarationsIn: self.
	m inferReturnTypeIn: self.
	m returnType ifNil:
		[m returnType: (self implicitReturnTypeFor: selector)].
	^m