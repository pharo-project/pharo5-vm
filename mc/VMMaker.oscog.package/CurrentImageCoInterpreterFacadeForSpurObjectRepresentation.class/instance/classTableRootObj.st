accessing
classTableRootObj
	hiddenRoots ifNil:
		[hiddenRoots := Array new: self memMgr classTableRootSlots + self memMgr hiddenRootSlots].
	^self oopForObject: hiddenRoots