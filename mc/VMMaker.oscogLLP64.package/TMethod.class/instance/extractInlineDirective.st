inlining support
extractInlineDirective
	"Scan the pragmas (or top-level statements) for an inlining directive of the form:

		<inline: <boolean|#never|#dontCare|#asSpecified|#always>

	 Answer a boolean equivalent to the argument of the directive or #dontCare if there is no inlining directive."

	sharedCase ifNotNil: [^false]. "don't auto-inline shared code; it gets handled specially"
	^self
		extractDirective: #inline:
		valueBlock:
			[:sendNode| #(true always) includes: (inline := sendNode args first value)]
		default: #dontCare