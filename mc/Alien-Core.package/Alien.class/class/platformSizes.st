platform
platformSizes
	^ PlatformSizes ifNil: [ PlatformSizes := self platformSizesIA32 ]