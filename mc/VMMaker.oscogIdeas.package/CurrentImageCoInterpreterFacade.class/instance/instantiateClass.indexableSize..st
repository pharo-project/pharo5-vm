instantiation
instantiateClass: classPointer indexableSize: size
	(self objectForOop: classPointer) caseOf:
		{[Array]	->	[^self oopForObject: (Array new: size)]}