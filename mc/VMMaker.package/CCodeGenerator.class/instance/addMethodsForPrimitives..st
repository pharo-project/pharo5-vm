public
addMethodsForPrimitives: classAndSelectorList 
	| verbose |
	verbose := false.
	classAndSelectorList do:
		[:classAndSelector | | aClass selector meth |
		aClass := Smalltalk at: classAndSelector first.
		selector := classAndSelector last.
		self addAllClassVarsFor: aClass.
"TPR - should pool vars also be added here?"

		"compile the method source and convert to a suitable translation method.
		 find the method in either the class or the metaclass"
		meth := self
					compileToTMethodSelector: selector
					in: ((aClass includesSelector: selector)
							ifTrue: [aClass]
							ifFalse: [aClass class]).
		meth primitive > 0 ifTrue:[meth preparePrimitiveName].
		"for old-style array accessing: 
		meth covertToZeroBasedArrayReferences."
		meth replaceSizeMessages.
		self addMethod: meth].

	self prepareMethods.
	verbose
		ifTrue: 
			[self printUnboundCallWarnings.
			self printUnboundVariableReferenceWarnings.
			logger cr].

	"code generation"
	self doInlining: true.

	methods do:[:m|
		"if this method is supposed to be a primitive (rather than a helper 
		routine), add assorted prolog and epilog items"
		m primitive > 0 ifTrue: [m preparePrimitivePrologue]].