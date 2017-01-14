utilities
baseTypeForType: aCType
	"Reduce various declarations to the most basic type we can determine."
	| type fpIndex closeidx openidx |
	type := aCType.
	((openidx := type indexOfSubCollection: 'const ') > 0
	and: [openidx = 1 or: [(type at: openidx) isSeparator]]) ifTrue:
		[type := type copyReplaceFrom: openidx to: openidx + 5 with: ''].
	((type beginsWith: 'unsigned') and: [(type includes: $:) and: [type last isDigit]]) ifTrue:
		[^#usqInt].
	"collapse e.g. void (*foo(int bar))(void) to void (*)(void)"
	(fpIndex := type indexOfSubCollection: '(*') > 0 ifTrue:
		["elide the function arguments after *, if there are any"
		 type := type copyReplaceFrom: (type indexOf: $( startingAt: fpIndex + 1)
					to: (type indexOf: $) startingAt: fpIndex + 1)
					with: ''.
		 "elide the function name after *, if there is one"
		 type := type copyReplaceFrom: fpIndex + 2
					to: (type indexOf: $) startingAt: fpIndex + 1)
					with: ')'].
	"collapse [size] to *"
	openidx := 0.
	[(openidx := type indexOf: $[ startingAt: openidx + 1) > 0
	 and: [(closeidx := type indexOf: $] startingAt: openidx + 1) > 0]] whileTrue:
		[type := type copyReplaceFrom: openidx to: closeidx with: '*'].
	^type withBlanksTrimmed