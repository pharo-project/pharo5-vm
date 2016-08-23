tests
testInterpreterProxyInterface
	"| fails |
	 fails := Set new.
	 [self new testInterpreterProxyInterface]
		on: AssertionFailure, TestFailure
		do: [:ex|
			fails add: ex messageText.
			ex resume].
	 fails asArray sort do:
		[:m| Transcript cr; nextPutAll: m; flush]"
	(VMClass allSubclasses select: [:ea| (ea name endsWith: 'Interpreter') or: [ea name endsWith: 'InterpreterMT']]) do:
		[:class|
		self testInterpreterProxyInterfaceIsConsistentFor: class]