object testing
isNonIntegerObject: oop
	"This list records the valid senders of isNonIntegerObject: as we replace uses of
	  isNonIntegerObject: by isNonImmediate: where appropriate."
	(#(reverseDisplayFrom:to:) includes: thisContext sender method selector) ifFalse:
		[self halt].
	^(oop bitAnd: 1) = 0