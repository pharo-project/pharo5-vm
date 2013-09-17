accessing
addToUnpairedMethodList: aCogMethod
	<option: #NewspeakVM>
	<var: #aCogMethod type: #'CogMethod *'>
	self assert: aCogMethod cmType = CMMethod.
	self assert: (unpairedMethodList == nil
				or: [unpairedMethodList cmType = CMMethod]).
	aCogMethod nextMethod: unpairedMethodList.
	unpairedMethodList := aCogMethod