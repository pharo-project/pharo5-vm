header access
isMarked: oop
	<api>
	"Answer if oop's mark bit is set"
	^((self longAt: oop) bitAnd: MarkBit) ~= 0