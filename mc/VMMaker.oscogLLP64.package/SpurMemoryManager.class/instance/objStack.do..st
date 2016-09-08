obj stacks
objStack: objStack do: aBlock
	"Evaluate aBinaryBlock with all indices and pages of elements in objStack"
	<inline: true>
	| objStackPage |
	objStack = nilObj ifTrue:
		[^self].
	self eassert: [self isValidObjStack: objStack].
	objStackPage := objStack.
	[objStackPage ~= 0] whileTrue:
		[| numOnThisPage |
		 numOnThisPage := self fetchPointer: ObjStackTopx ofObject: objStackPage.
		 numOnThisPage + ObjStackFixedSlots - 1 to: ObjStackFixedSlots by: -1 do:
			[:i| aBlock value: i value: objStackPage].
		 objStackPage := self fetchPointer: ObjStackNextx ofObject: objStackPage]