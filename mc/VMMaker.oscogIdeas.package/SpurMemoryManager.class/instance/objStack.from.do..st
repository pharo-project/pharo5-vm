obj stacks
objStack: objStack from: start do: aBlock
	"Evaluate aBlock with all elements from start (0-relative) in objStack.
	 Answer the size of the stack *before* the enumeration commences.
	 This evaluates in top-of-stack-to-bottom order.  N.B. this is also stable
	 if aBlock causes new elements to be added to the objStack, but
	 unstable if aBlock causes elements to be removed."
	<inline: true>
	| size objStackPage numToEnumerate |
	self eassert: [self isValidObjStack: weaklingStack].
	size := self fetchPointer: ObjStackTopx ofObject: objStack.
	objStackPage := self fetchPointer: ObjStackNextx ofObject: objStack.
	[objStackPage ~= 0] whileTrue:
		[size := size + ObjStackLimit.
		 self assert: (self fetchPointer: ObjStackTopx ofObject: objStackPage) = ObjStackLimit.
		 objStackPage := self fetchPointer: ObjStackNextx ofObject: objStackPage].
	numToEnumerate := size - start.
	objStackPage := objStack.
	[numToEnumerate > 0] whileTrue:
		[| numOnThisPage numToEnumerateOnThisPage topIndex |
		 numOnThisPage := self fetchPointer: ObjStackTopx ofObject: objStackPage.
		 numToEnumerateOnThisPage := numToEnumerate min: numOnThisPage.
		 topIndex := numOnThisPage + ObjStackFixedSlots - 1.
		 topIndex
			to: topIndex - numToEnumerateOnThisPage + 1
			by: -1
			do:	[:i|
				self assert: (self isWeak: (self fetchPointer: i ofObject: objStackPage)).
				aBlock value: (self fetchPointer: i ofObject: objStackPage)].
		 numToEnumerate := numToEnumerate - numToEnumerateOnThisPage.
		 objStackPage := self fetchPointer: ObjStackNextx ofObject: objStackPage].
	^size