utilities
unreachableMethods
	"Return a collection of methods that are never invoked."

	| neededSelectors previousSize visited |
	neededSelectors := Set new.
	"collect the exports"
	methods do:
		[:m|
		 m export ifTrue:
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
				 neededSelectors
					add: m selector;
					addAll: m allCalls]]].
	 neededSelectors size > previousSize]
		whileTrue:
			[previousSize := neededSelectors size].

	^methods reject: [:m| neededSelectors includes: m selector]