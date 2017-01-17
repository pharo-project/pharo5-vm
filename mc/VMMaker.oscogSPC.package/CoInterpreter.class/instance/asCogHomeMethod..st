frame access
asCogHomeMethod: aCogMethod
	"Coerce either a CMMethod or a CMBlock to the home CMMethod"
	<var: #aCogMethod type: #'CogBlockMethod *'>
	<returnTypeC: #'CogMethod *'>
	^aCogMethod cmType = CMMethod
		ifTrue: [self cCoerceSimple: aCogMethod to: #'CogMethod *']
		ifFalse: [aCogMethod cmHomeMethod]