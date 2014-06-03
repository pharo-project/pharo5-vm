public
addStructClass: aClass
	"Add the non-accessor methods of the given struct class to the code base."

	aClass prepareToBeAddedToCodeGenerator: self.
	self addClassVarsFor: aClass.
	self addPoolVarsFor: aClass.
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
				self addStructMethodFor: aClass selector: sel]].
	aClass declareCVarsIn: self