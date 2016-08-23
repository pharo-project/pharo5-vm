simulation
tryToRunTranslatedPrimitive: method types: types subsidiaries: subsidiaryMethods
	"Evaluate a translated primitive method using the receiver as its receiver.
	 Supply integers or proxies for the arguments as necessary."
	<doNotGenerate>
	| cg args result |
	interpreterProxy methodArgumentCount ~= method numArgs ifTrue:
		[^interpreterProxy primitiveFail].
	cg := translatedMethodCache at: #CCodeGenerator.
	args := (1 to: method numArgs)
				with: types
				collect:
					[:i :type |
					 (self translatedPrimitiveArgument: i ofType: type using: cg) ifNil:
						[^interpreterProxy primitiveFail]].
	result := self executeTranslatedPrimitiveMethod: method arguments: args subsidiaries: subsidiaryMethods.
	interpreterProxy failed ifFalse:
		[result == interpreterProxy
			ifTrue: [interpreterProxy pop: interpreterProxy methodArgumentCount]
			ifFalse:
				[result isInteger
					ifTrue: [interpreterProxy methodReturnValue: (interpreterProxy integerObjectOf: result)]
					ifFalse: [self halt]]]