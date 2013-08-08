utilities
localizeGlobalVariables
	| candidates elected |

	"find all globals used in only one method"
	candidates := globalVariableUsage select: [:e | e size = 1].
	(candidates keys select: [:k| vmClass mustBeGlobal: k]) do:
		[:k| candidates removeKey: k].
	elected := Set new.

	"move any suitable global to be local to the single method using it"
	candidates keysAndValuesDo:
		[:key :targets | 
		targets do:
			[:name | | procedure |
			procedure := methods at: name.
			procedure isRealMethod ifTrue:
				[logger notNil ifTrue:
					[logger ensureCr; show: key, ' localised to ', name; cr].
				elected add: (procedure locals add: key).
				variableDeclarations at: key ifPresent:
					[:v |
					procedure declarationAt: key put: v.
					variableDeclarations removeKey: key]]]].
	elected do: [:ea| (variables includes: ea) ifTrue: [self checkDeleteVariable: ea]].
	variables removeAllFoundIn: elected