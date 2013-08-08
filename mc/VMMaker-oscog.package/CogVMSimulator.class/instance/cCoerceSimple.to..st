translation support
cCoerceSimple: value to: cTypeString
	"Type coercion for translation and simulation.
	 For simulation answer a suitable surrogate for the struct types"
	^cTypeString caseOf:
	   {	[#'char *']				->	[value].
		[#'void *']				->	[value].
		[#sqInt]					->	[value].
		[#'void (*)()']			->	[value].
		[#'void (*)(void)']		->	[value].
		[#'CogMethod *']		->	[cogit cogMethodSurrogateAt: value asUnsignedInteger].
		[#'CogBlockMethod *']	->	[cogit cogBlockMethodSurrogateAt: value asUnsignedInteger] }