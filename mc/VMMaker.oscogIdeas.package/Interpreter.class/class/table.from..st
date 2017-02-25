initialization
table: anArray from: specArray 
	"SpecArray is an array of either (index selector) or (index1 
	index2 selector)."
	| contiguous |
	contiguous := 0.
	specArray do: [:spec | 
			(spec at: 1) = contiguous
				ifFalse: [self error: 'Non-contiguous table entry'].
			spec size = 2
				ifTrue: [anArray at: (spec at: 1) + 1
						put: (spec at: 2).
					contiguous := contiguous + 1]
				ifFalse: [(spec at: 1) to: (spec at: 2) do: [:i | anArray at: i + 1 put: (spec at: 3)].
					contiguous := contiguous + ((spec at: 2) - (spec at: 1)) + 1]]