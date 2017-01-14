garbage collection
markAndTraceLiteral: literal in: cogMethod at: address
	"Mark and trace a literal in a sqInt variable of cogMethod."
	<var: #cogMethod type: #'CogMethod *'>
	<var: #address type: #'sqInt *'>
	self subclassResponsibility