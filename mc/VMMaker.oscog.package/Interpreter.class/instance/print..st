debug printing
print: s
	"For testing in Smalltalk, this method should be overridden in a subclass."

	<var: #s type: 'char *'>
	self cCode: 'printf("%s", s)'.