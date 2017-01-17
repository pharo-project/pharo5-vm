analysis
linkedSuperSendCacheTags
	"An example; answer the cache tags for linked super sends.  They should all be
	 selectors because super sends don't have their cache tag rewritten when linked."
	<doNotGenerate>
	| cacheTags |
	cacheTags := Set new.
	methodZone methodsDo:
		[:m|
		 m cmType = CMMethod ifTrue:
			[self sendSitesIn: m do:
				[:a :mcpc| | entryPoint |
				 entryPoint := backEnd callTargetFromReturnAddress: mcpc.
				 entryPoint > methodZoneBase ifTrue:
					[self offsetAndSendTableFor: entryPoint
						annotation: a
						into:
							[:off :table|
							 off = cmNoCheckEntryOffset ifTrue:
								[cacheTags add: (backEnd inlineCacheTagAt: mcpc)]]]]]].
	^cacheTags