debugging
msg: s
	<var: #s type: 'char *'>
	self cCode: 'fprintf(stderr, "\n%s: %s", getModuleName(), s)'
		inSmalltalk: [super msg: s].
	^0