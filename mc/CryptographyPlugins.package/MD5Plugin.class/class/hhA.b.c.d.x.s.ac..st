code generation - macros
hhA: a b: b c: c d: d x: x s: s ac: ac

	^'
	{1} := {1} + ({2} + {3} + {4}).
	{1} := {5} + {6}.' format: { a. self hX: b y: c z: d. x. ac. self rotateLeftX: a n: s. b }