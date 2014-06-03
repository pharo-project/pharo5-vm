translation
prepareToBeAddedToCodeGenerator: aCodeGen
	"It is either this or scan cmacro methods for selectors."
	aCodeGen retainMethods: #(enterSmalltalkExecutiveImplementation)