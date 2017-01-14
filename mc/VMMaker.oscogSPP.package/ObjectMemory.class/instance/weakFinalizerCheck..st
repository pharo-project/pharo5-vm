finalization
weakFinalizerCheck: oop
	"Our oop has at least 2 non-weak fixed slots (this is assured before entering this method, in
	#finalizeReference:.
	We are assuming that if its first non-weak field is an instance of ClassWeakFinalizationList class,
	then we should add this oop to that list, by storing it to list's first field and
	also, updating the oop's 2nd fixed slot to point to the value which we overridden:
	
	list := oop instVarAt: 1.
	list class == WeakFinalizationList ifTrue: [
		first := list instVarAt: 1.
		oop instVarAt: 2 put: first.
		list instVarAt: 1 put: oop ]	"
	<inline: true>
	| listOop listItemOop |

	listOop := self fetchPointer: 0 ofObject: oop.
	(self fetchClassOf: listOop) = (self splObj: ClassWeakFinalizer) ifTrue:
		[listItemOop := self fetchPointer: 0 ofObject: listOop.
		 self storePointer: 1 ofObject: oop withValue: listItemOop. 
		 self storePointer: 0 ofObject: listOop withValue: oop]