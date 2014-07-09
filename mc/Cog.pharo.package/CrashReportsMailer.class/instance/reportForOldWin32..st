reporting
reportForOldWin32: lines
	| dateAndTime module idx stackTop |

	lines withIndexDo:
		[:l :i|
		(dateAndTime isNil
		and: [(l beginsWith: '--------------------')
		and: [i < lines size]]) ifTrue:
			[dateAndTime := lines at: i + 1].
		((l beginsWith: 'Stack dump:')
		and: [i < lines size]) ifTrue:
			 "Occasionally there is a bogus blank line between the label and the first entry"
			[(stackTop := (lines at: i + 1) isEmpty) ifTrue:
				[stackTop := lines at: i + 2]]].
	dateAndTime := self win32DateFor: dateAndTime.
	(dateAndTime between: startDate and: endDate) ifFalse:
		[^nil].
	module := (lines detect: [:l| l beginsWith: 'Module: ']) allButFirst: 8.
	(idx := module indexOfSubCollection: '\Teleplace') > 0 ifTrue:
		[module := module copyFrom: idx to: module size].
	(module first isLetter and: [module second = $:]) ifTrue:
		[module := module allButFirst: 2].
	"a stack entry looks like
		 0x9c2490 I NetNameResolver class>localHostAddress 271185968: a(n) NetNameResolver class
		293325136 s BlockClosure>on:do:
	 but if there is no stack there may be any old crap after Stack dump: so squash errors."
	[stackTop := (stackTop subStrings: ' ') allButFirst: 2.
	 stackTop := stackTop first: (stackTop findFirst: [:t| t first isDigit]) - 1.
	 stackTop := stackTop fold: [:a :b| a, ' ', b]]
		on: Error
		do: [:ex| stackTop := '?'].
	^stackTop, ' in ', module