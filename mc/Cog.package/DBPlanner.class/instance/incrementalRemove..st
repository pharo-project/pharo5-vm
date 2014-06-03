adding
incrementalRemove: c
	"Entry point for retracting a constraint. Remove the given constraint,
	 which should be satisfied, and incrementally update the dataflow
	 graph.

	 Details: Retracting the given constraint may allow some currently
	 unsatisfiable downstream constraint be satisfied. We thus collect a
	 list of unsatisfied downstream constraints and attempt to satisfy
	 each one in turn. This list is sorted by constraint strength,
	 strongest first, as a heuristic for avoiding unnecessarily adding
	 and then overriding weak constraints."

	| out unsatisfied |
	out := c output.
	c markUnsatisfied.
	c removeFromGraph.
	unsatisfied := self removePropagateFrom: out.
	unsatisfied do: [: u | self incrementalAdd: u].