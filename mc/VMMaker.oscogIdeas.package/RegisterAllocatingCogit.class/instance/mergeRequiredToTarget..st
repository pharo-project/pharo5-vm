bytecode generator support
mergeRequiredToTarget: targetSimStack
	<var: 'targetSimStack' type: #'SimStackEntry *'>
	<inline: true>
	<var: 'here' type: #'SimStackEntry *'>
	<var: 'there' type: #'SimStackEntry *'>
	simStackPtr to: 0 by: -1 do:
		[:i| | here there |
		 here := self simStack: simStack at: i.
		 there := self simStack: targetSimStack at: i.
		 (here isMergedWithTargetEntry: there) ifFalse:
			[^true]].
	^false