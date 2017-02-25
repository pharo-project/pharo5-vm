debugging
codeEntryFor: address
	<api>
	<returnTypeC: #'char *'>
	<var: #address type: #'char *'>
	0 to: trampolineTableIndex - 3 by: 2 do:
		[:i|
		(address between: (trampolineAddresses at: i + 1)
				and: (trampolineAddresses at: i + 3) - 1) ifTrue:
			[^trampolineAddresses at: i + 1]].
	^nil