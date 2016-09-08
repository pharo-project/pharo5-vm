snapshot
initialHeadroom: extraVmMemory givenFreeOldSpaceInImage: freeOldSpaceInImage
	"Answer how much headroom to allocate, if any, on loading the image.
	 If the image already conatins lots of free space, we should not allocate lots more."
	<inline: true>
	| headroom |
	headroom := extraVmMemory = 0
					ifTrue: [growHeadroom ifNil: [16*1024*1024]]
					ifFalse: [extraVmMemory].
	freeOldSpaceInImage >= headroom ifTrue:
		[^0].
	freeOldSpaceInImage >= (headroom * 7 // 8) ifTrue:
		[^headroom // 8].
	freeOldSpaceInImage >= (headroom * 3 // 4) ifTrue:
		[^headroom // 4].
	freeOldSpaceInImage >= (headroom * 5 // 8) ifTrue:
		[^headroom * 3 // 8].
	freeOldSpaceInImage >= (headroom // 2) ifTrue:
		[^headroom // 2].
	^headroom