testing
validateOopsIn: object
	| fieldPtr limit former header | 
	"for each oop in me see if it is legal"
	fieldPtr := object + self baseHeaderSize.	"first field"
	limit := object + (self lastPointerOf: object).	"a good field"
	[fieldPtr > limit] whileFalse: [
		former := self longAt: fieldPtr.
		(self validOop: former) ifFalse: [self error: 'invalid oop in pointers object'].
		fieldPtr := fieldPtr + self wordSize].
	"class"
	header := self baseHeader: object.
	(header bitAnd: CompactClassMask) = 0 ifTrue: [	
		former := (self classHeader: object) bitAnd: AllButTypeMask.
		(self validOop: former) ifFalse: [self halt]].