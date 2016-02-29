*CogVMMakerPharoCompatibility
asTranslationMethodOfClass: aClass 
	
	| definingClass |
	
	"HACK. We need to get the class that defines the method. This depends on the class defining the method.
	Since the new AST does not have access to the defining class if there is no semantic analysis, we need to access the context to know how to obtain the correct class."
	
	(thisContext sender selector = #superExpansionNodeFor:args:)
		ifTrue: [ definingClass := (thisContext sender tempNamed: 'superMethod') methodClass ].
	
	thisContext sender selector = #accessorsAndAssignmentsForSubMethodNamed:actuals:depth:interpreterClass:into:
		ifTrue: [ definingClass := BitBltSimulation ].
	
	self assert: definingClass notNil.
	
	"We recompile the method to get the same kind of AST node. If we ask for the methodNode "
	^ (self asOldASTInClass: definingClass)
			asTranslationMethodOfClass: aClass