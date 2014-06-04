primitives
primitivePopAndFail
	"Pops in a failing primitive"
	<export: true>
	interpreterProxy pop: interpreterProxy methodArgumentCount + 1.
	interpreterProxy primitiveFail.