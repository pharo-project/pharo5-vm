accessing
removeFromUnpairedMethodList: aCogMethod
	<option: #NewspeakVM>
	<var: #aCogMethod type: #'CogMethod *'>
	| prevMethod |
	<var: #prevMethod type: #'CogMethod *'>
	self assert: aCogMethod cmType = CMMethod.
	aCogMethod asUnsignedInteger = unpairedMethodList ifTrue:
		[unpairedMethodList := aCogMethod nextMethodOrIRCs.
		 ^nil].
	prevMethod := self cCoerceSimple: unpairedMethodList to: #'CogMethod *'.
	[prevMethod notNil] whileTrue:
		[self assert: (prevMethod ~~ nil and: [prevMethod cmType = CMMethod]).
		 prevMethod nextMethodOrIRCs = aCogMethod asUnsignedInteger ifTrue:
			[prevMethod nextMethodOrIRCs: aCogMethod nextMethodOrIRCs.
			 ^nil].
		  prevMethod := self cCoerceSimple: prevMethod nextMethodOrIRCs to: #'CogMethod *']