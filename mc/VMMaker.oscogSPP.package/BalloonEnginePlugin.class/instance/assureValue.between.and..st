bezier-loading
assureValue: val1 between: val2 and: val3
	"Make sure that val1 is between val2 and val3."
	<inline: true>
	val2 > val3 ifTrue:[
		val1 > val2 ifTrue:[^val2].
		val1 < val3 ifTrue:[^val3].
	] ifFalse:[
		val1 < val2 ifTrue:[^val2].
		val1 > val3 ifTrue:[^val3].
	].
	^val1	