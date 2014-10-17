patching
editTo: dest "<FileStream>"
	source reopen.
	[substitutions do:
		[:tuple|
		 [:start :end :substitution|
		  [source position + 1 < start] whileTrue:
			[dest nextPut: source next].
		   dest nextPutAll: (substitution
							copyReplaceAll: (String with: Character cr)
							with: (String with: Character lf)).
		   source skip: end - start + 1] valueWithArguments: tuple].
	 dest nextPutAll: source upToEnd]
		ensure: [source close]