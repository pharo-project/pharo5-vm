accessing
classTableRootObj
	hiddenRoots ifNil:
		[hiddenRoots := Array new: objectMemory classTableRootSlots + objectMemory hiddenRootSlots].
	^self oopForObject: hiddenRoots