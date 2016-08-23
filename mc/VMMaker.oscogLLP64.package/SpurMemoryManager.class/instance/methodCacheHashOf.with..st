interpreter access
methodCacheHashOf: selector with: classTag
	"Sicne class tags are indices or immediate tags, it is necessary to shift the class
	 tag w.r.t. the selector to include the full class index/immediate tags in the hash."
	<inline: true>
	^selector bitXor: classTag << 2 "num cache probes - 1"