translation
instVarNamesAndTypesForTranslationDo: aBinaryBlock
	"Define a CallbackContext, the argument to sendInvokeCallbackContext:
	 self typedef"

	self instVarNames do:
		[:ivn|
		aBinaryBlock
			value: ivn
			value: (ivn caseOf: {
					['thunkp']				-> [#'void *'].
					['stackp']				-> [#'long *'].
					['intregargsp']			-> [#'long *'].
					['floatregargsp']		-> [#'double *'].
					['rvs']					-> [
						'union {
							long valword;
							struct { int low, high; } valleint64;
							struct { int high, low; } valbeint64;
							double valflt64;
							struct { void *addr; long size; } valstruct;
						}'].
					['savedCStackPointer']		-> [#'void *'].
					['savedCFramePointer']		-> [#'void *'].
					['trampoline']				-> [#'jmp_buf'].
					['savedReenterInterpreter']	-> [#'jmp_buf']})]