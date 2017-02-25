jit - api
clearCogCompiledCode
	"Free all methods"
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	NewspeakVM ifTrue: [unpairedMethodList := nil].
	cogMethod := coInterpreter cCoerceSimple: baseAddress to: #'CogMethod *'.
	[cogMethod asUnsignedInteger < mzFreeStart] whileTrue:
		[cogMethod cmType = CMMethod ifTrue:
			[self freeMethod: cogMethod].
		 cogMethod := self methodAfter: cogMethod].
	self manageFrom: baseAddress to: limitAddress