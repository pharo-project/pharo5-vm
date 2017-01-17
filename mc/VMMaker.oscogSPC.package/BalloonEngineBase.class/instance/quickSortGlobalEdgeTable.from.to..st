GET processing
quickSortGlobalEdgeTable: array from: i to: j 
	"Sort elements i through j of self to be nondescending according to
	sortBlock."
	"Note: The original loop has been heavily re-written for C translation"
	| di dij dj tt ij k l n tmp again before |
	<var: #array type:'int *'>
	<inline: false>
	"The prefix d means the data at that index."
	(n := j + 1  - i) <= 1 ifTrue: [^0].	"Nothing to sort." 
	 "Sort di,dj."
	di := array at: i.
	dj := array at: j.
	before := self getSorts: di before: dj. "i.e., should di precede dj?"
	before ifFalse:[
		tmp := array at: i.
		array at: i put: (array at: j).
		array at: j put: tmp.
		tt := di.	di := dj.	dj := tt].
	n <= 2 ifTrue:[^0].

	"More than two elements."
	ij := (i + j) // 2.  "ij is the midpoint of i and j."
	dij := array at: ij.  "Sort di,dij,dj.  Make dij be their median."
	before := (self getSorts: di before: dij). "i.e. should di precede dij?"
	before ifTrue:[
		before := (self getSorts: dij before: dj). "i.e., should dij precede dj?"
		before ifFalse:["i.e., should dij precede dj?"
			tmp := array at: j.
			array at: j put: (array at: ij).
			array at: ij put: tmp.
			dij := dj]
	] ifFalse:[  "i.e. di should come after dij"
		tmp := array at: i.
		array at: i put: (array at: ij).
		array at: ij put: tmp.
		 dij := di].
	n <= 3 ifTrue:[^0].

	 "More than three elements."
	"Find k>i and l<j such that dk,dij,dl are in reverse order.
	Swap k and l.  Repeat this procedure until k and l pass each other."
	k := i.
	l := j.

	again := true.
	[again] whileTrue:[
		before := true.
		[before] whileTrue:[
			k <= (l := l - 1)
				ifTrue:[	tmp := array at: l.
						before := self getSorts: dij before: tmp]
				ifFalse:[before := false].
		].
		before := true.
		[before] whileTrue:[
			(k := k + 1) <= l
				ifTrue:[	tmp := array at: k.
						before := self getSorts: tmp before: dij]
				ifFalse:[before := false]].

		again := k <= l.
		again ifTrue:[
			tmp := array at: k.
			array at: k put: (array at: l).
			array at: l put: tmp]].

	"Now l<k (either 1 or 2 less), and di through dl are all less than or equal to dk
	through dj.  Sort those two segments."
	self quickSortGlobalEdgeTable: array from: i to: l.
	self quickSortGlobalEdgeTable: array from: k to: j.