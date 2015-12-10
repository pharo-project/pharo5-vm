code generation
round: i

	| selector |
	selector := #(ffA:b:c:d:x:s:ac: ggA:b:c:d:x:s:ac: hhA:b:c:d:x:s:ac: iiA:b:c:d:x:s:ac:) at: (i // 16) + 1.
	^self 
		perform: selector
		withArguments: 
			(self abcd at: (i \\ 4) + 1), 
			{ 
				'(buffer at: {1})' format: { self indexArray at: i + 1 }.
				self shiftArray at: i + 1.
				self sineArray at: i + 1 }