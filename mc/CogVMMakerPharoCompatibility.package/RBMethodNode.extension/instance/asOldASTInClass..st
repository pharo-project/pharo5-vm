*CogVMMakerPharoCompatibility
asOldASTInClass: aDefiningClass 
	
	"We recompile the method to get the same kind of AST node. If we ask for the methodNode "
	^ Compiler new
			parse: self formattedCode
			in: aDefiningClass
			notifying: nil