primitives
testTypePropagationBasicNoPropagateFunctional
	"Ensure that types are propagated correctly"
	| shouldBeInt |
	<export: true>
	shouldBeInt := self getByteFunctional.
	"shoudBeInt should be int, not unsigned char"
	shouldBeInt := 12345.
	interpreterProxy pushBool: shouldBeInt > 256.