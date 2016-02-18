primitive generators
genLoadArgAtDepth: n into: reg
	"All machine code primitives apart from perform: have only
	 register arguments, hence no arg load code is necessary."
	<inline: true>
	self assert: n < objectRepresentation numRegArgs