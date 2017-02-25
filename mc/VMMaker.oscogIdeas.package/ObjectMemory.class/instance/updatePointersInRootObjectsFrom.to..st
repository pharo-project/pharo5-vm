gc -- compaction
updatePointersInRootObjectsFrom: memStart to: memEnd 
	"update pointers in root objects"
	| oop |
	<inline: false>
	1 to: rootTableCount do: [:i | 
			oop := rootTable at: i.
			((self oop: oop isLessThan: memStart)
					or: [self oop: oop isGreaterThanOrEqualTo: memEnd])
				ifTrue: ["Note: must not remap the fields of any object twice!"
					"remap this oop only if not in the memory range 
					covered below"
					self remapFieldsAndClassOf: oop]]