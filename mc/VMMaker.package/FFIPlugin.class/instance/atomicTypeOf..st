primitive support
atomicTypeOf: value
	^(value bitAnd: FFIAtomicTypeMask) >> FFIAtomicTypeShift