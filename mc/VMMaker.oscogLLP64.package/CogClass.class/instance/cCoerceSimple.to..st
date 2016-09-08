translation support
cCoerceSimple: value to: cTypeString
	<doNotGenerate>
	"Type coercion for translation and simulation.
	 For simulation answer a suitable surrogate for the struct types"
	^cTypeString caseOf:
	   {	[#'unsigned long']							->	[value].
		[#'unsigned int']							->	[value].
		[#sqInt]										->	[value].
		[#'sqIntptr_t']								->	[value].
		[#'usqIntptr_t']								->	[value].
		[#usqInt]									->	[value].
		[#sqLong]									->	[value].
		[#usqLong]									->	[value].
		[#'AbstractInstruction *']					->	[value].
		[#'BytecodeFixup *']						->	[value].
		[#'CogMethod *']							->	[value].
		[#'char *']									->	[value].
		[#'sqInt *']									->	[value].
		[#'void *']									->	[value].
		[#void]										->	[value].
		[#'void (*)()']								->	[value].
		[#'void (*)(void)']							->	[value].
		[#'unsigned long (*)(void)']					->	[value].
		[#'void (*)(unsigned long,unsigned long)']	->	[value] }