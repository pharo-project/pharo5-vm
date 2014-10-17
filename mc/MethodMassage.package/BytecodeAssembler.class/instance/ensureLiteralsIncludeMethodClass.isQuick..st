private
ensureLiteralsIncludeMethodClass: literals isQuick: isQuick
	"Check whether literals includes the methodClass association (and hence by implication the penultimate literal).
	 If not, add a suitable one.  In the assembly case the literal will be missing."
	literals size > 0 ifTrue:
		[| last |
		isQuick ifTrue: "support Newspeak accessors"
			[self assert: literals size = 2.
			 ^literals].
		last := literals last.
		(last isVariableBinding
		and: [last value = code methodClass
		and: [last key == nil or: [last == code methodClass binding]]]) ifTrue:
			[^literals]].
	^literals, { code selector. code methodClass ifNotNil: [:class| class binding] }