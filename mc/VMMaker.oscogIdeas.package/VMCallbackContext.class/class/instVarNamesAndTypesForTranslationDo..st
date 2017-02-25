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
					['stackp']				-> [#'sqIntptr_t *'].
					['intregargsp']			-> [#'sqIntptr_t *'].
					['floatregargsp']		-> [#'double *'].
					['rvs']					-> [
						'union {
							sqIntptr_t valword;
							struct { int low, high; } valleint64;
							struct { int high, low; } valbeint64;
							double valflt64;
							struct { void *addr; sqIntptr_t size; } valstruct;
						}'].
					['savedCStackPointer']		-> [#'void *'].
					['savedCFramePointer']		-> [#'void *'].
					['trampoline']				-> [#'jmp_buf'].
					['savedReenterInterpreter']	-> [#'jmp_buf']})]