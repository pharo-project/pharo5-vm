inlining
pruneUnreachableMethods
	"Remove any methods that are not reachable. Retain methods needed by the translated classes - see implementors of requiredMethodNames"
 	
	| neededSelectors newMethods previousSize visited |
	"add all the exported methods and all the called methods to the requiredSelectors"
	"keep all the fake methods (macros and struct accessors; these are needed
	 to ensure correct code generation."

	neededSelectors := Set withAll: requiredSelectors.
	methods do: [ :m |
		m export ifTrue:
			[neededSelectors add: m selector].
		m isAPIMethod ifTrue:
			[neededSelectors add: m selector].
		m isRealMethod ifFalse:
			[neededSelectors add: m selector]].

	"Now compute the transitive closure..."
	previousSize := neededSelectors size.
	visited := IdentitySet new: methods size.
	[neededSelectors do:
		[:s|
		(methods at: s ifAbsent: []) ifNotNil:
			[:m|
			(visited includes: m) ifFalse:
				[visited add: m.
				 (m isRealMethod
				  and: [self shouldGenerateMethod: m]) ifTrue:
					[neededSelectors addAll: m allCalls]]]].
	 neededSelectors size > previousSize]
		whileTrue:
			[previousSize := neededSelectors size].

	"build a new dictionary of methods from the collection of all the ones to keep"			
	newMethods := Dictionary new: neededSelectors size.
	neededSelectors do:
		[:sel|
		methods at: sel ifPresent: [:meth| newMethods at: sel put: meth]].
	methods := newMethods