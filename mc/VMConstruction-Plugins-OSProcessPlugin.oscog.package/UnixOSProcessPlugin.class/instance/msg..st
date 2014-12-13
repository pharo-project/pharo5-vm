private - sigaltstack
msg: s 
	<var: #s type: 'char *'>
	self flag: #todo. "ESTEBAN: For some reason I needed to add this method otherwise compilation was failing. Hopefully I can remove this later"
	self cCode: 'fprintf(stderr, "\n%s: %s", moduleName, s)'