simulation only
offset: aClass of: fieldSymbol
	"This is implemented by stddef's offsetof macro."
	<doNotGenerate>
	^aClass caseOf:
		{ [CogMethod] -> [cogMethodSurrogateClass offsetOf: fieldSymbol] }