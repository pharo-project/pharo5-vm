utilities
isolatedPrototypes
	"SpurBootstrap isolatedPrototypes"
	| prototypes |
	prototypes := (self systemNavigation allMethodsSelect:
						[:m| m selector includesSubString: 'PROTOTYPE'])
							collect: [:mr| mr compiledMethod].
	^prototypes select:
		[:m|
		m methodClass == self class
			ifTrue:
				[(m pragmaAt: #indirect) notNil
				  and: [prototypes noneSatisfy:
						[:p|
						p selector == m selector
						and: [p methodClass ~~ m methodClass]]]]
			ifFalse:
				[prototypes noneSatisfy:
					[:p|
					p selector == m selector
					and: [p methodClass == self class
					and: [(p pragmaAt: #indirect) notNil]]]]]