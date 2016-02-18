simulation support
executeTranslatedPrimitiveMethod: method arguments: args subsidiaries: subsidiaryMethods
	<doNotGenerate>
	"Execute the method within a doesNotUnderstand: handler that will
	 catch sends of asciiValue and evaluate any subsidiary methods.."
	^[interpreterProxy withArgs: args executeMethod: method]
		on: MessageNotUnderstood
		do: [:ex|
			ex receiver == interpreterProxy ifTrue:
				[ex resume:
					(self executeTranslatedPrimitiveMethod:
							(subsidiaryMethods
								at: ex message selector
								ifAbsent: [ex pass])
						arguments: ex message arguments
						subsidiaries: subsidiaryMethods)].
			(ex receiver isInteger
			and: [ex message selector == #asciiValue]) ifTrue:
				[ex resume: ex receiver].
			ex pass]