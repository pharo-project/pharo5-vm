accessing
openPICWithSelector: aSelector
	| openPIC |
	<var: #openPIC type: #'CogMethod *'>
	<returnTypeC: #'CogMethod *'>
	openPIC := openPICList.
	[(openPIC == nil
	  or: [openPIC selector = aSelector]) ifTrue:
		[^openPIC].
	 "N.B. Use self rather than coInterpreter to avoid attempting to cast nil.
	  Conversion to CogMethod done in the nextOpenPIC accessor."
	 openPIC := self cCoerceSimple: openPIC nextOpenPIC to: #'CogMethod *'.
	 true] whileTrue