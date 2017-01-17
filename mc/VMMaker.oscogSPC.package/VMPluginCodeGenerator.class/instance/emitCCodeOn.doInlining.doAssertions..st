C code generator
emitCCodeOn: aStream doInlining: inlineFlag doAssertions: assertionFlag
	"Generate twice; the first time to collect the used functions, the second to output the used functions."
	| savedHeaders |
	savedHeaders := headerFiles copy.
	[super emitCCodeOn: NullStream new doInlining: inlineFlag doAssertions: assertionFlag]
		on: MessageNotUnderstood
		do: [:ex|
				(#(cr crtab: ensureCr peekLast space tab tab:) includes: ex message selector) ifTrue:
					[ex resume: nil].
				ex pass].
	headerFiles := savedHeaders.
	super emitCCodeOn: aStream doInlining: inlineFlag doAssertions: assertionFlag