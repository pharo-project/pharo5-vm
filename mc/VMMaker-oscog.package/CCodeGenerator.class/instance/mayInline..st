inlining
mayInline: sel
	"Answer true if the method with the given selector may be inlined."

	^sel ~~ #assert: and: [inlineList includes: sel]