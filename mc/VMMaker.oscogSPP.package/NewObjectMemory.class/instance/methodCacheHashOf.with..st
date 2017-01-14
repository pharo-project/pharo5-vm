interpreter access
methodCacheHashOf: selector with: classTag
	"Since class tags are class objects, and classes are aligned on a 4 byte boundary there
	 is no need to shift the class to include the least significant bits of the class in the hash."
	<inline: true>
	^selector bitXor: classTag