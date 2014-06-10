utilities
bootstrapImage: imageFileBaseName
	"SpurBootstrap bootstrapImage: '/Users/eliot/Squeak/Squeak4.5/Squeak4.5-13680'"
	| imageFormat |
	imageFormat := ImageFormat fromFile: imageFileBaseName, '.image'.
	imageFormat requiresClosureSupport ifFalse:
		[self error: 'Can''t bootstrap this image since Spur assumes closure support.'].
	imageFormat requiresSpurSupport ifTrue:
		[self error: 'This image is already in Spur format.'].
	imageFormat is32Bit ifTrue:
		[^SpurBootstrap32 new bootstrapImage: imageFileBaseName].
	self error: '64-bit support and 64-bit generation as-yet-unimplemented'