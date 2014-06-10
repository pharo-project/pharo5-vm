object testing
isNonIntegerObject: oop
	"This list records the valid senders of isNonIntegerObject: as we replace uses of
	  isNonIntegerObject: by isNonImmediate: where appropriate."
	(#(	on:do: "from the dbeugger"
		reverseDisplayFrom:to:
		primitiveObjectAtPut
		isCogMethodReference:) includes: thisContext sender method selector) ifFalse:
		[self halt].
	^super isNonIntegerObject: oop