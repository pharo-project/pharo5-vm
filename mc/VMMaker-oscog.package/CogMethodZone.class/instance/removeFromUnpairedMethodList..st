accessing
removeFromUnpairedMethodList: aCogMethod
	<option: #NewspeakVM>
	<var: #aCogMethod type: #'CogMethod *'>
	| prevMethod |
	<var: #prevMethod type: #'CogMethod *'>
	self assert: aCogMethod cmType = CMMethod.
	aCogMethod = unpairedMethodList ifTrue:
		[unpairedMethodList := aCogMethod nextMethod.
		 ^nil].
	prevMethod := unpairedMethodList.
	[prevMethod notNil] whileTrue:
		[self assert: (prevMethod ~~ nil and: [prevMethod cmType = CMMethod]).
		 prevMethod nextMethod = aCogMethod ifTrue:
			[prevMethod nextMethod: aCogMethod nextMethod.
			 ^nil].
		  prevMethod := prevMethod nextMethod]