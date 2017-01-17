object enumeration
isEnumerableObject: objOop
	"Answer if objOop should be included in an allObjects...Do: enumeration.
	 Non-objects should be excluded; these are bridges and free chunks."
	| classIndex |
	<inline: true>
	classIndex := self classIndexOf: objOop.
	self assert: ((self long64At: objOop) ~= 0
				  and: [classIndex < (numClassTablePages * self classTablePageSize)]).
	^classIndex >= self isForwardedObjectClassIndexPun