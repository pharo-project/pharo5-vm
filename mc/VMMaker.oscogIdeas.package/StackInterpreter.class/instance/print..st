debug printing
print: s
	"For testing in Smalltalk, this method should be overridden in a subclass."
	<api>
	<var: #s type: #'char *'>
	self cCode: 'fputs(s, stdout)'