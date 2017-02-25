C code generation
isStructReference: varNode in: aCodeGen
	^(varNode structTargetKindIn: aCodeGen) notNil