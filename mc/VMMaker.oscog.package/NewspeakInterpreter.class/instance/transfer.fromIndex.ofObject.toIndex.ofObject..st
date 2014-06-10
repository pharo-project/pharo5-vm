utilities
transfer: count fromIndex: firstFrom ofObject: fromOop toIndex: firstTo ofObject: toOop
	"Transfer the specified fullword fields, as from calling context to called context"
	
	"Assume: beRootIfOld: will be called on toOop."
	| fromIndex toIndex lastFrom |
	<inline: true>
	self flag: #Dan.  "Need to check all senders before converting this for 64 bits"
	fromIndex := fromOop + (firstFrom * BytesPerWord).
	toIndex := toOop + (firstTo * BytesPerWord).
	lastFrom := fromIndex + (count * BytesPerWord).
	[self oop: fromIndex isLessThan: lastFrom]
		whileTrue: [fromIndex := fromIndex + BytesPerWord.
			toIndex := toIndex + BytesPerWord.
			self
				longAt: toIndex
				put: (self longAt: fromIndex)]