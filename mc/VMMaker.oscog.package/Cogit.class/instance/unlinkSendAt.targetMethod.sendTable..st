in-line cacheing
unlinkSendAt: mcpc targetMethod: targetMethod sendTable: sendTable
	<inline: true>
	| unlinkedRoutine |
	unlinkedRoutine := sendTable at: (targetMethod cmNumArgs min: NumSendTrampolines - 1).
	backEnd
		rewriteInlineCacheAt: mcpc asInteger
		tag: (self inlineCacheValueForSelector: targetMethod selector in: enumeratingCogMethod at: mcpc)
		target: unlinkedRoutine.
	codeModified := true