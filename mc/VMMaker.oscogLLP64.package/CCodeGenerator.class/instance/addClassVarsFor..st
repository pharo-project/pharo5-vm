public
addClassVarsFor: aClass
	"Add the class variables for the given class to the code base as constants."
	aClass classPool associationsDo:
		[:assoc | self addConstantForBinding: assoc]