testing
sistaNeedsStoreCheck
	<inline: true>
	"The store check can be ignored if the value assigned doesn't need it (immediate, etc)
	In addition, the extB low bit is marked by the optimizer if the store check is not required"
	^ self ssTopNeedsStoreCheck and: [ self extBSpecifiesStoreCheck ]