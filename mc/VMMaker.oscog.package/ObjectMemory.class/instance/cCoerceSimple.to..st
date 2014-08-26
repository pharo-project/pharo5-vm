simulation support
cCoerceSimple: value to: cTypeString
	^cTypeString caseOf:
	   {	[#'char *']	->	[value] }