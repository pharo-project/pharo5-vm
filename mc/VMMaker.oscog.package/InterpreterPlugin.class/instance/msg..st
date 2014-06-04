debugging
msg: s 
	<var: #s type: 'char *'>
	self cCode: 'fprintf(stderr, "\n%s: %s", moduleName, s)' inSmalltalk: [Transcript cr; show: self class moduleName , ': ' , s; endEntry].
	^0