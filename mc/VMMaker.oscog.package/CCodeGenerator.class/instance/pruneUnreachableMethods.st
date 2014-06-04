inlining
pruneUnreachableMethods
	"Remove any methods that are not reachable. Retain methods needed by the translated classes - see implementors of requiredMethodNames"
 	
	| newMethods previousSize visited |
	"add all the exported methods and all the called methods to the requiredSelectors"
	"keep all the fake methods (macros and struct accessors; these are needed
	 to ensure correct code generation."

	methods do: [ :m |
		m export ifTrue:
			[requiredSelectors add: m selector].
		m isRealMethod ifFalse:
			[requiredSelectors add: m selector]].

	"Now compute the transitive closure..."
	previousSize := requiredSelectors size.
	visited := IdentitySet new: methods size.
	[requiredSelectors do:
		[:s|
		(methods at: s ifAbsent: []) ifNotNil:
			[:m|
			(visited includes: m) ifFalse:
				[visited add: m.
				 m isRealMethod ifTrue:
					[requiredSelectors addAll: m allCalls]]]].
	 requiredSelectors size > previousSize]
		whileTrue:
			[previousSize := requiredSelectors size].

	"build a new dictionary of methods from the collection of all the ones to keep"			
	newMethods := Dictionary new: requiredSelectors size.
	requiredSelectors do:
		[:sel|
		methods at: sel ifPresent:[:meth| newMethods at: sel put: meth]].
	methods := newMethods