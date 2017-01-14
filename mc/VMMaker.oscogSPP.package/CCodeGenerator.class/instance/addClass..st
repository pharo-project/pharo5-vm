public
addClass: aClass
	"Add the variables and methods of the given class to the code base."

	aClass prepareToBeAddedToCodeGenerator: self.
	self checkClassForNameConflicts: aClass.
	self addClassVarsFor: aClass.
	"ikp..."
	self addPoolVarsFor: aClass.
	(aClass inheritsFrom: VMStructType) ifFalse:
		[variables addAll: (self instVarNamesForClass: aClass)].
	self retainMethods: (aClass requiredMethodNames: self options).
	
	'Adding Class ' , aClass name , '...'
		displayProgressAt: Sensor cursorPoint
		from: 0
		to: aClass selectors size
		during:
			[:bar |
			 aClass selectors doWithIndex:
				[:sel :i | | source |
				bar value: i.
				self addMethodFor: aClass selector: sel]].
	aClass declareCVarsIn: self