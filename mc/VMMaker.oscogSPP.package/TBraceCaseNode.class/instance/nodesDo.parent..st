enumerating
nodesDo: aBlock parent: parent
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	caseLabels do:
		[:node| node nodesDo: aBlock parent: self.].
	cases do:
		[:node| node nodesDo: aBlock parent: self].
	aBlock value: self value: parent