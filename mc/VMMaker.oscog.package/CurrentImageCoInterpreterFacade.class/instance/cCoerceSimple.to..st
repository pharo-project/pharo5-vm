debug support
cCoerceSimple: value to: cTypeString
	"Type coercion for translation and simulation.
	 For simulation answer a suitable surrogate for the struct types"
	^cTypeString
		caseOf:
		   {	[#'CogMethod *']		->	[value < 0 ifTrue: [value] ifFalse: [cogit cogMethodSurrogateAt: value asUnsignedInteger]].
			[#'CogBlockMethod *']	->	[cogit cogBlockMethodSurrogateAt: value asUnsignedInteger] }
		otherwise: [super cCoerceSimple: value to: cTypeString]