inlining
mayInline: sel
	"Answer if the method with the given selector may be inlined."

	^(self isAssertSelector: sel) not and: [inlineList includes: sel]