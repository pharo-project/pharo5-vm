bezier-loading
subdivideBezierFrom: index
	"Recursively subdivide the curve on the bezier stack."
	| otherIndex index1 index2 |
	<inline: false>
	otherIndex := self subdivideBezier: index.
	otherIndex = index ifFalse:[
		index1 := self subdivideBezierFrom: index.
		engineStopped ifTrue:[^0].
		index2 := self subdivideBezierFrom: otherIndex.
		engineStopped ifTrue:[^0].
		index1 >= index2
			ifTrue:[^index1]
			ifFalse:[^index2]
	].
	^index