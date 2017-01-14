become
restoreHeaderOf: obj to: objHeader
	"helper for restoreHeaderOf: for subclasses to override"
	<inline: true> "for subclasses"
	self longAt: obj put: objHeader