accessing
removeFromOpenPICList: anOpenPIC
	<var: #anOpenPIC type: #'CogMethod *'>
	| prevPIC |
	<var: #prevPIC type: #'CogMethod *'>
	self assert: anOpenPIC cmType = CMOpenPIC.
	anOpenPIC = openPICList ifTrue:
		["N.B. Use self rather than coInterpreter to avoid attempting to cast nil.
		  Conversion to CogMethod done in the nextOpenPIC accessor."
		 openPICList := self cCoerceSimple: anOpenPIC nextOpenPIC to: #'CogMethod *'.
		 ^nil].
	prevPIC := openPICList.
	[self assert: (prevPIC ~~ nil
				and: [prevPIC cmType = CMOpenPIC]).
	 prevPIC nextOpenPIC = anOpenPIC asInteger ifTrue:
		[prevPIC nextOpenPIC: anOpenPIC nextOpenPIC.
		 ^nil].
	  prevPIC := self cCoerceSimple: prevPIC nextOpenPIC to: #'CogMethod *'.
	  true] whileTrue