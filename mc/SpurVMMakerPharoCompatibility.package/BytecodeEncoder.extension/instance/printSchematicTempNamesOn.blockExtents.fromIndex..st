*SpurVMMakerPharoCompatibility
printSchematicTempNamesOn: aStream blockExtents: blockExtents fromIndex: startIndex
	"Print the locals in the blockExtent startIndex, recursing to print any locals in nested blockExtents.
	 Answer the index of the last blockExtent printed."
	| blockExtent subsequentIndex |
	blockExtent := blockExtents at: startIndex.
	blockExtent first > 0 ifTrue:
		[aStream nextPut: $[ ].
	((blockExtentsToLocals at: blockExtent) reject: [:local| local isRemote])
		do:	[:local|
			local isIndirectTempVector
				ifTrue:
					[aStream nextPut: $(.
					 local remoteTemps
						do: [:remoteLocal| aStream nextPutAll: remoteLocal key]
						separatedBy: [aStream space].
					 aStream nextPut: $)]
				ifFalse: [aStream nextPutAll: local key]]
		separatedBy: [aStream space].
	subsequentIndex := startIndex + 1.
	[subsequentIndex <= blockExtents size
	 and: [(blockExtents at: subsequentIndex) last < blockExtent last]] whileTrue:
		[subsequentIndex := self printSchematicTempNamesOn: aStream
								blockExtents: blockExtents
								fromIndex: subsequentIndex].
	blockExtent first > 0 ifTrue:
		[aStream nextPut: $] ].
	^subsequentIndex