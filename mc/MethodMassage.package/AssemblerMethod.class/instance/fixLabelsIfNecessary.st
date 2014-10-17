private
fixLabelsIfNecessary
	| map |
	fixLabels ~~ true ifTrue: [^self].
	map := Dictionary new.
	instructions do:
		[:inst|
		(self isLabel: inst) ifTrue:
			[map at: inst key put: inst]].
	instructions do:
		[:inst|
		((self isLabel: inst) not
		 and: [#(jump: jump:if: jumpLong: jumpLong:if:
				pushClosureCopyNumCopiedValues:numArgs:blockSize:) includes: inst selector]) ifTrue:
			[inst selector first = $j
				ifTrue:
					[inst arguments first isInteger ifFalse:
						[inst arguments at: 1 put: (map at: inst arguments first)]]
				ifFalse:
					[inst arguments last isInteger ifFalse:
						[inst arguments at: inst numArgs put: (map at: inst arguments last)]]]].
	fixLabels := false