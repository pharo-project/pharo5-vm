stack pages
zeroStackPage
	"In its own method as a debugging hook.
	 Frame pointers should have been written back already."
	<inline: true>
	self assert: (stackPage = 0
				or: [stackPage headFP = framePointer
					and: [stackPage headSP = stackPointer]]).
	stackPage := 0