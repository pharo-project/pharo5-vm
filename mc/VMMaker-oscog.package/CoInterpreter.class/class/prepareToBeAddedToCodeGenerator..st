translation
prepareToBeAddedToCodeGenerator: aCodeGen
	"Override to avoid repeating StackInterpreter's preparations and to delete
	 StackInterpreter & StackInterpreterPrimitives methods we override."
	aCodeGen removeVariable: 'cogit'.
	self selectors do:
		[:sel|
		 (superclass whichClassIncludesSelector: sel) ifNotNil:
			[aCodeGen removeMethodForSelector: sel]].
	"It is either this or scan cmacro methods for selectors."
	aCodeGen retainMethods: #(enterSmalltalkExecutiveImplementation)