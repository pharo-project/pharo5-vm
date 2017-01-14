translation support
cCoerceSimple: value to: cTypeString
	"Type coercion for translation and simulation.
	 For simulation answer a suitable surrogate for the struct types"
	^cTypeString
		caseOf:
		   {	[#'CogMethod *']		->	[cogit cogMethodSurrogateAt: value asUnsignedInteger].
			[#'CogBlockMethod *']	->	[cogit cogBlockMethodSurrogateAt: value asUnsignedInteger].
			[#'NSSendCache *']		->	[cogit nsSendCacheSurrogateAt: value asUnsignedInteger] }
		otherwise: [value]