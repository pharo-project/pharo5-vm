code generation - macros
rotateLeftX: x n: n

	^'(({1} << {2}) bitOr: ({1} >> (32 - {2})))' format: { x. n }
	