page access
stackPageFor: pointer "<Integer>"
	<inline: true>
	<var: #pointer type: #'void *'>
	<returnTypeC: #'StackPage *'>
	^self stackPageAt: (self pageIndexFor: pointer)