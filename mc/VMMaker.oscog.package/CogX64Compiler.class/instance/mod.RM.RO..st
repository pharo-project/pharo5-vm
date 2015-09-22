encoding
mod: mod RM: regMode RO: regOpcode
	^mod << 6 + ((regOpcode bitAnd: 7) << 3) + (regMode bitAnd: 7)