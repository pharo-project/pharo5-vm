primitive support
mark: obj
	<inline: true>
	self baseHeader: obj put: ((self baseHeader: obj) bitOr: MarkBit)