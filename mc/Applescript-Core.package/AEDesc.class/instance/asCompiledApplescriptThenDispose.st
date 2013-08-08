converting
asCompiledApplescriptThenDispose

	| CAD |
	CAD := self asCompiledApplescript.
	self dispose.
	^CAD