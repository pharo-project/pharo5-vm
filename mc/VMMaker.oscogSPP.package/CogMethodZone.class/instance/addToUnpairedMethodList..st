accessing
addToUnpairedMethodList: aCogMethod
	<option: #NewspeakVM>
	<var: #aCogMethod type: #'CogMethod *'>
	self assert: aCogMethod cmType = CMMethod.
	self assert: (cogit noAssertMethodClassAssociationOf: aCogMethod methodObject) = objectMemory nilObject.
	self assert: (unpairedMethodList == nil
				or: [(self cCoerceSimple: unpairedMethodList to: #'CogMethod *') cmType = CMMethod]).
	aCogMethod nextMethodOrIRCs: unpairedMethodList.
	unpairedMethodList := aCogMethod asUnsignedInteger