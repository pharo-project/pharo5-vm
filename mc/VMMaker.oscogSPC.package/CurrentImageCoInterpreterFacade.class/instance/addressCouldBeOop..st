debug support
addressCouldBeOop: anOop 
	[self objectForOop: anOop]
		on: Error
		do: [:ex| ^false].
	^true