primitives
testTypePropagationBasicFunctional
	"Ensure that types are propagated correctly"
	| shouldBeInt |
	<export: true>
	"the resulting byte should be truncated by the functions and expanded back to sqInt"
	shouldBeInt := self getByteFunctional.
	interpreterProxy pushBool: shouldBeInt < 256.
