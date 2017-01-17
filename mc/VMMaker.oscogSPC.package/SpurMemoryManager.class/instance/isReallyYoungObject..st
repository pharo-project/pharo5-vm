object testing
isReallyYoungObject: obj
	<api>
	"Answer if obj is young. This for compatibility with SqueakV3 where
	 the GC makes all objects young during full GC.  Spur doesn't do so."
	^self isYoungObject: obj