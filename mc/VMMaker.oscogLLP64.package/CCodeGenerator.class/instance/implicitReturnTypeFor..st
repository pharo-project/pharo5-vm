type inference
implicitReturnTypeFor: aSelector
	"Answer the default return type for mthods of the defining class of
	 aSelector. Default to #sqInt if there is no method, or if the method's
	 defining class doesn't understand implicitReturnTypeFor:."
	| m |
	m := methods at: aSelector ifAbsent: [^#sqInt].
	^[m definingClass implicitReturnTypeFor: aSelector]
		on: MessageNotUnderstood
		do: [:ex|
			ex message selector ~~ #implicitReturnTypeFor: ifTrue:
				[ex pass].
			#sqInt]