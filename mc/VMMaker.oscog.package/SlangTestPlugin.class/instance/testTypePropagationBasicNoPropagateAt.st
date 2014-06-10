primitives
testTypePropagationBasicNoPropagateAt
	"Ensure that types are propagated correctly"
	| buffer shouldBeInt |
	<export: true>
	<var: #buffer declareC: 'sqInt buffer[1] = { 12345 }'>
	shouldBeInt := self getByteNonFunctionalAt: buffer.
	"shoudBeInt should be int, not unsigned char"
	shouldBeInt := 12345.
	interpreterProxy pushBool: shouldBeInt > 256.