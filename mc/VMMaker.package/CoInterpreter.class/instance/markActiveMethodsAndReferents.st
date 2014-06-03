cog jit support
markActiveMethodsAndReferents
	<api>
	| thePage |
	<var: #thePage type: #'StackPage *'>
	0 to: numStackPages - 1 do:
		[:i|
		thePage := stackPages stackPageAt: i.
		(stackPages isFree: thePage) ifFalse:
			[self markCogMethodsAndReferentsOnPage: thePage]]