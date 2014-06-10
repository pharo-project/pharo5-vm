debug printing
printFloat: f
	"For testing in Smalltalk, this method should be overridden in a subclass."
	<cmacro: '(f) printf("%g", f)'>
	self print: f