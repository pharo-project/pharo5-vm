generate machine code
regenerateCounterReferences: methodEndAddress
	<var: #label type: #'AbstractInstruction *'>
	<var: #dependentInstruction type: #'AbstractInstruction *'>
	0 to: counterIndex - 1 do:
		[:i| | label dependentInstruction |
		label := self addressOf: (counters at: i).
		label address: methodEndAddress - ((counterIndex - i) * CounterBytes).
		dependentInstruction := label dependent.
		[dependentInstruction concretizeAt: dependentInstruction address.
		 dependentInstruction := dependentInstruction dependent.
		 dependentInstruction ~= nil] whileTrue]