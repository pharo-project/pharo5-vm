C code generator
emitCExpression: aParseNode on: aStream 
	"Emit C code for the expression described by the given parse node."

	self emitCExpression: aParseNode on: aStream indent: 0