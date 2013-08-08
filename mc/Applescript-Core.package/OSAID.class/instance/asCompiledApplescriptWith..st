conversions
asCompiledApplescriptWith: anApplescriptInstance

	| anAEDesc |
	anAEDesc := self asAEDescWith: anApplescriptInstance.
	anAEDesc ifNil: [^nil].
	^anAEDesc asCompiledApplescriptThenDispose	