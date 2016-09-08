enumerating
nodesDo: aBlock
	"Apply aBlock to all nodes in the receiver.
	 N.B. This is assumed to be bottom-up, leaves first."
	caseLabels do:
		[:node| node nodesDo: aBlock].
	cases do:
		[:node| node nodesDo: aBlock].
	aBlock value: self