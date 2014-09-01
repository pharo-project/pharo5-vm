method prototypes
MCMethodDefinitionPROTOTYPEinitializeWithClassName: classString
classIsMeta: metaBoolean
selector: selectorString
category: catString
timeStamp: timeString
source: sourceString
	className := classString asSymbol.
	selector := selectorString asSymbol.
	category := catString ifNil: [Categorizer default] ifNotNil: [catString asSymbol].
	timeStamp := timeString.
	classIsMeta := metaBoolean.
	source := sourceString withSqueakLineEndings