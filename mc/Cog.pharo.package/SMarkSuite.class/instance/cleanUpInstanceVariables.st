running
cleanUpInstanceVariables
	"Make sure all variables that are 'user variables' get cleaned"
	
	self class allInstVarNames do: [ :name |
		name = 'runner' ifFalse: [
			self instVarNamed: name put: nil ] ]