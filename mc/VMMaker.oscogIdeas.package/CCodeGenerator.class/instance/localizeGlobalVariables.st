utilities
localizeGlobalVariables
	| candidates elected localized |

	"find all globals used in only one method"
	candidates := globalVariableUsage select: [:e | e size = 1].
	"Don't localize globals; nor those that are only assigned to; they're for debugging..."
	(candidates keys select: [:k| (vmClass mustBeGlobal: k)
								or: [(self methodNamed: (globalVariableUsage at: k) anyOne)
										ifNil: [false]
										ifNotNil: [:m| (m readsVariable: k) not]]]) do:
		[:k| candidates removeKey: k].
	
	elected := Set new.
	localized := Dictionary new. "for an ordered report"
	"move any suitable global to be local to the single method using it"
	candidates keysAndValuesDo:
		[:key :targets |
		targets do:
			[:name |
			(methods at: name ifAbsent: []) ifNotNil:
				[:procedure | | newDeclaration |
				(procedure isRealMethod
				 and: [self shouldGenerateMethod: procedure]) ifTrue:
					[(localized at: name ifAbsentPut: [SortedCollection new]) add: key.
					elected add: (procedure locals add: key).
					newDeclaration := variableDeclarations at: key ifAbsent: ['sqInt ', key].
					(self initializerForInstVar: key inStartClass: procedure definingClass) ifNotNil:
						[:initializerNode|
						newDeclaration := String streamContents:
												[:s|
												 s nextPutAll: newDeclaration; nextPutAll: ' = '.
												 initializerNode emitCCodeOn: s level: 0 generator: self]].
					procedure declarationAt: key put: newDeclaration.
					variableDeclarations removeKey: key ifAbsent: []]]]].
	logger ifNotNil:
		[localized keys asSortedCollection do:
			[:name|
			(localized at: name) do:
				[:var|
				logger ensureCr; show: var, ' localised to ', name; cr]]].
	elected do: [:ea| (variables includes: ea) ifTrue: [self checkDeleteVariable: ea]].
	variables removeAllFoundIn: elected