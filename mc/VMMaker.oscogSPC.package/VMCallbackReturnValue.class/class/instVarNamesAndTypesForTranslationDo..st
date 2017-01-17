translation
instVarNamesAndTypesForTranslationDo: aBinaryBlock
	"Define a CallbackContext, the argument to sendInvokeCallbackContext:
	 self typedef"

	| rvsType |
	VMCallbackContext instVarNamesAndTypesForTranslationDo:
		[:ivname :type| ivname = 'rvs' ifTrue: [rvsType := type]].
	self instVarNames do:
		[:ivn|
		aBinaryBlock
			value: ivn
			value: (ivn = 'crvrvs'
					ifTrue: [rvsType]
					ifFalse: [#int])]