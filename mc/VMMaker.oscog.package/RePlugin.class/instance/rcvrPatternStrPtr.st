rcvr linkage
rcvrPatternStrPtr

	<inline: true>
	<returnTypeC: 'char *'>
	^self 
		cCoerce: (interpreterProxy fetchArray: 0 ofObject: rcvr) 
		to: 'char *'.