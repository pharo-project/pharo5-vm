tests
testComputeFormat
	"self testComputeFormat"
	#(	(normal 0)
		(bytes 16)
		(words 12)
		(variable 2)
		(weak 4)
		(ephemeron 5)
		(immediate 7)
		(compiledMethod 24)) do:
		[:tuple|
		 [:type :instSpec| | fmt |
		   fmt := [self ClassBuilderPROTOTYPEcomputeFormat: type instSize: 0 forSuper: Object ccIndex: 0]
					on: MessageNotUnderstood
					do: [:ex|
						ex message selector ~~ #format:variable:words:pointers:weak: ifTrue:
							[ex pass].
						self perform: #ClassBuilderPROTOTYPEformat:variable:words:pointers:weak:
							withArguments: ex message arguments].
		   self assert: (fmt >> 16 = instSpec
						or: [type = #compiledMethod and: [fmt = CompiledMethod format]]).
		 ] valueWithArguments: tuple]