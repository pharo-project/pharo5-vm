primitive support
atomicTypeOf: typeSpec
	^(typeSpec bitAnd: FFIAtomicTypeMask) >> FFIAtomicTypeShift