inlining
collectInlineList: inlineFlagOrSymbol
	"Make a list of methods that should be inlined.  If inlineFlagOrSymbol == #asSpecified
	 only inline methods marked with <inline: true>.  If inlineFlagOrSymbol == #asSpecifiedOrQuick
	 only inline methods marked with <inline: true> or methods that are quick (^constant, ^inst var)."
	"Details: The method must not include any inline C, since the
	 translator cannot currently map variable names in inlined C code.
	 Methods to be inlined must be small or called from only one place."

	| selectorsOfMethodsNotToInline callsOf |
	self assert: (#(true false asSpecified asSpecifiedOrQuick) includes: inlineFlagOrSymbol).
	selectorsOfMethodsNotToInline := Set new: methods size.
	selectorsOfMethodsNotToInline addAll: macros keys.
	apiMethods ifNotNil:
		[selectorsOfMethodsNotToInline addAll: apiMethods keys].
	methods do:
		[:m|
		m isStructAccessor ifTrue:
			[selectorsOfMethodsNotToInline add: m selector]].

	"build dictionary to record the number of calls to each method"
	callsOf := Dictionary new: methods size * 2.
	methods keysAndValuesDo:
		[:s :m|
		(m isRealMethod
		 and: [self shouldGenerateMethod: m]) ifTrue:
			[callsOf at: s put: 0]].

	"For each method, scan its parse tree once or twice to:
		1. determine if the method contains unrenamable C code or declarations or has a C builtin
		2. determine how many nodes it has
		3. increment the sender counts of the methods it calls"
	inlineList := Set new: methods size * 2.
	(methods reject: [:m| selectorsOfMethodsNotToInline includes: m selector]) do:
		[:m| | inlineIt hasUnrenamableCCode nodeCount |
		((breakSrcInlineSelectors includes: m selector)
		 and: [breakOnInline isNil]) ifTrue:
			[self halt].
		inlineIt := #dontCare.
		(translationDict includesKey: m selector)
			ifTrue: [hasUnrenamableCCode := true]
			ifFalse:
				[hasUnrenamableCCode := m hasUnrenamableCCode.
				 nodeCount := 0.
				 m parseTree nodesDo:
					[:node|
					node isSend ifTrue:
						[callsOf
							at: node selector
							ifPresent:
								[:senderCount| callsOf at: node selector put: senderCount + 1]].
					 nodeCount := nodeCount + 1].
				inlineIt := m extractInlineDirective].  "may be true, false, #always, #never or #dontCare"
		(hasUnrenamableCCode or: [inlineIt == false])
			ifTrue: "don't inline if method has C code or contains negative inline directive"
				[inlineIt == true ifTrue:
					[logger
						ensureCr;
						nextPutAll: 'failed to inline ';
						nextPutAll: m selector;
						nextPutAll: ' as it contains unrenamable C declarations or C code';
						cr; flush].
				selectorsOfMethodsNotToInline add: m selector]
			ifFalse:
				[(inlineFlagOrSymbol caseOf: {
						[#asSpecified]			-> [inlineIt == true].
						[#asSpecifiedOrQuick]	-> [inlineIt == true or: [m compiledMethod isQuick]].
						[true]					-> [nodeCount < 40 or: [inlineIt == true]].
						[false]					-> [false]})
					ifTrue: "inline if method has no C code and is either small or contains inline directive"
						[inlineList add: m selector]
					ifFalse:
						[(#(asSpecified asSpecifiedOrQuick) includes: inlineFlagOrSymbol) ifTrue:
							[selectorsOfMethodsNotToInline add: m selector]]]].

	(#(asSpecified asSpecifiedOrQuick) includes: inlineFlagOrSymbol)
		ifTrue:
			[methods do: [:m| m inline ifNil: [m inline: (inlineList includes: m selector)]]]
		ifFalse:
			[callsOf associationsDo:
				[:assoc|
				(assoc value = 1
				 and: [(selectorsOfMethodsNotToInline includes: assoc key) not]) ifTrue:
					[inlineList add: assoc key]]]