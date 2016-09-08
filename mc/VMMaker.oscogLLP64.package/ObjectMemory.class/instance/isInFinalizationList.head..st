finalization
isInFinalizationList: oop head: listHead
	"it is known that oop's first fixed slot points to an instance of special object - ClassWeakFinalizer ,
	so it is safe to assume that we can iterate over it to figure out if oop is already in that list"
	<option: #PharoVM>
	| listItem |

	listItem := listHead.
	
	[ listItem == self nilObject ] whileFalse: [
		listItem == oop ifTrue: [ ^ true ].
		listItem := self fetchPointer: 1 ofObject: listItem.   
	].
	^ false
