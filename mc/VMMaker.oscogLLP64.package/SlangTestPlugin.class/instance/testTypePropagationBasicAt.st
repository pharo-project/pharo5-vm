primitives
testTypePropagationBasicAt
	"Ensure that types are propagated correctly"
	| buffer shouldBeInt |
	<export: true>
	<var: #buffer declareC: 'sqInt buffer[1] = { 12345 }'>
	"the resulting byte should be truncated by the functions and expanded back to sqInt"
	shouldBeInt := self getByteNonFunctionalAt: buffer.
	interpreterProxy pushBool: shouldBeInt < 256.
