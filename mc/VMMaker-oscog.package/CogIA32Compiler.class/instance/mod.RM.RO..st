encoding
mod: mod RM: regMode RO: regOpcode
	^mod << 6 + (regOpcode << 3) + regMode