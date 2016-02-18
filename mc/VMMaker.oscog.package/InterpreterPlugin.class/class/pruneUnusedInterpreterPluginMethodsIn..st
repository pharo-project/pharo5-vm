translation
pruneUnusedInterpreterPluginMethodsIn: aCodeGen
	aCodeGen unreachableMethods do:
		[:m|
		 m definingClass = InterpreterPlugin ifTrue:
			[aCodeGen removeMethodForSelector: m selector]]