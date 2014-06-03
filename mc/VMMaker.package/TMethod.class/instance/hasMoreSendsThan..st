utilities
hasMoreSendsThan: nSends
	"Answer the number of nodes in this method's parseTree (a rough measure of its size)."

	| cnt |
	cnt := 0.
	parseTree nodesDo:
		[:node|
		(node isSend
		 and: [(cnt := cnt + 1) >= nSends]) ifTrue:
			[^true]].
	^false