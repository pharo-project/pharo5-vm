comparing
<= anotherMethodReference

	classSymbol < anotherMethodReference classSymbol ifTrue: [^true].
	classSymbol > anotherMethodReference classSymbol ifTrue: [^false].
	classIsMeta = anotherMethodReference classIsMeta ifFalse: [^classIsMeta not].
	^methodSymbol <= anotherMethodReference methodSymbol
