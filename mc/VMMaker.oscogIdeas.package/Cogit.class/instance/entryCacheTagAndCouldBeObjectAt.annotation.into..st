in-line cacheing
entryCacheTagAndCouldBeObjectAt: mcpc annotation: annotation into: trinaryBlock
	"Evaluate trinaryBlock with the entryPoint, inline cache tag and whether the cache
	 tag could be an object, for the send at mcpc with annotation annotation."
	<inline: true>
	| cacheTag entryPoint tagCouldBeObj |
	cacheTag := backEnd inlineCacheTagAt: mcpc asInteger.
	entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
	"in-line cache tags are the selectors of sends if sends are unlinked,
	 the selectors of super sends (entry offset = cmNoCheckEntryOffset),
	 the selectors of open PIC sends (entry offset = cmEntryOffset, target is an Open PIC)
	 or in-line cache tags (classes, class indices, immediate bit patterns, etc).
	 Note that selectors can be immediate so there is no guarantee that they
	 are markable/remappable objects."
	tagCouldBeObj := self inlineCacheTagsAreIndexes not
						and: [objectRepresentation inlineCacheTagsMayBeObjects
							or: [self entryPointTagIsSelector: entryPoint]].
	trinaryBlock
		value: entryPoint
		value: cacheTag
		value: tagCouldBeObj