testing
isStructSendIn: aCodeGen
	"Answer if the recever is a send of a structure accessor.
	 This is tricky.  We want
		foo bar => foo->bar
		foo bar => foo.bar
		foo bar: expr => foo->bar = expr
		foo bar: expr => foo.bar = expr
	 depending on whether foo is a struct or a pointer to a struct,
	 but only if both foo is a struct type and bar is a field accessor.
	 The tricky cases are self-sends within struct class methods.  Here we need to
	 distinguish between self-sends of ordinary methods from self sends of accessors."
	^arguments size <= 1
	   and: [(receiver structTargetKindIn: aCodeGen) notNil
	   and: [(aCodeGen methodNamed: selector)
				ifNil: [false]
				ifNotNil: [:method| method isStructAccessor]]]