object enumeration
allOldSpaceObjectsFrom: initialObject do: aBlock
	"Enumerate all objects (i.e. exclude bridges, forwarders and free chunks)
	 in oldSpace starting at initialObject."
	<inline: true>
	self allOldSpaceEntitiesFrom: initialObject
		do: [:objOop|
			 (self isEnumerableObject: objOop) ifTrue:
				[aBlock value: objOop]]