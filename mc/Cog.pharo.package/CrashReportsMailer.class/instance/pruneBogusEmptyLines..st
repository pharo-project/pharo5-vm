parsing
pruneBogusEmptyLines: lines
	"Eliminate duplicate empty lines from broken CR-LF to LF-LF conversions."
	| firstEmpty lastEmpty |
	(firstEmpty := lines findFirst: [:l| l isEmpty]) = 0 ifTrue:
		[^lines].
	lastEmpty := firstEmpty.
	[(lines at: lastEmpty + 2) isEmpty] whileTrue:
		[lastEmpty := lastEmpty + 2].
	^(lines copyFrom: 1 to: firstEmpty - 1),
	   ((firstEmpty + 1 to: lastEmpty - 1 by: 2) collect: [:i| lines at: i]),
	   (lines copyFrom: lastEmpty + 1 to: lines size)