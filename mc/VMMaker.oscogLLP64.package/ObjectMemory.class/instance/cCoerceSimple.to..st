simulation support
cCoerceSimple: value to: cTypeString
	<doNotGenerate>
	^cTypeString caseOf:
	   {	[#'char *']			->	[value].
		[#'unsigned int']	->	[value]. }