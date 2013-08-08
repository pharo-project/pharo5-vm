reporting
reportForNewWin32: lines
	| dateAndTime reason stStackTop cStackTop |

	lines withIndexDo:
		[:l :i|
		(l beginsWith: 'Session Summary:') ifTrue:
			[^nil]. "Not a VM bug report, ignore it."
		(dateAndTime isNil
		and: [(l beginsWith: '--------------------')
		and: [i < lines size]]) ifTrue:
			[dateAndTime := lines at: i + 1].
		((l beginsWith: 'Smalltalk stack dump:')
		and: [i < lines size]) ifTrue:
			[stStackTop := lines at: i + 1].
		((l beginsWith: 'Stack backtrace:')
		and: [i < lines size]) ifTrue:
			[cStackTop := lines at: i + 1]].
	dateAndTime isNil ifTrue:
		[^nil].
	dateAndTime := self win32DateFor: dateAndTime.
	(dateAndTime between: startDate and: endDate) ifFalse:
		[^nil].
	reason := (lines detect: [:l| l beginsWith: 'Reason: '] ifNone: []) ifNotNil: [:rl| rl allButFirst: 8].
	"a stack entry looks like
		 0x9c2490 I NetNameResolver class>localHostAddress 271185968: a(n) NetNameResolver class
		t293325136 s BlockClosure>on:do:"
	stStackTop ifNotNil:
		[stStackTop := (stStackTop subStrings: ' ') allButFirst: 2.
		 stStackTop := stStackTop first: (stStackTop findFirst: [:t| t first isDigit]) - 1.
		 stStackTop := stStackTop fold: [:a :b| a, ' ', b]].
	^String streamContents:
		[:s|
		reason ifNotNil: [s nextPutAll: reason; cr].
	 	stStackTop ifNotNil: [s nextPutAll: stStackTop; cr].
		cStackTop ifNotNil: [s nextPutAll: cStackTop]]