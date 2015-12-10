code generation - macros
fX: x y: y z: z

	^'(({1} bitAnd: {2}) bitOr: ({1} bitInvert32 bitAnd: {3}))' format: { x. y. z }