become
removeYoungRoot: obj
	"Remove the given young root from the root table (for freeObject: for becomeForward:)."
	<inline: false>
	1 to: rootTableCount do:
		[:i|
		obj = (rootTable at: i) ifTrue:"swap obj with last entry"
			[rootTable at: i put: (rootTable at: rootTableCount).
			rootTableCount := rootTableCount - 1.
			^true]].
	^false "not found"