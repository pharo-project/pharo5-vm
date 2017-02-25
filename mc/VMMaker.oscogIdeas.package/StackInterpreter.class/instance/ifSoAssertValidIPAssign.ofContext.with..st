frame access
ifSoAssertValidIPAssign: index ofContext: maybeMarriedContext with: anOop
	self assert: (index ~= InstructionPointerIndex
				or: [(objectMemory isContextNonImm: maybeMarriedContext) not
				or: [| mo |
					mo := self fetchPointer: MethodIndex ofObject: maybeMarriedContext.
					(anOop = objectMemory nilObject
					 or: [(objectMemory isIntegerObject: anOop)
						  and: [(objectMemory integerValueOf: anOop)
								between: (LiteralStart + (objectMemory literalCountOf: mo)) * objectMemory bytesPerOop
								and: (objectMemory numBytesOf: mo)]])]])