code generation - macros
gX: x y: y z: z

	^'(({1} bitAnd: {3}) bitOr: ({2} bitAnd: {3} bitInvert32))' format: { x. y. z }