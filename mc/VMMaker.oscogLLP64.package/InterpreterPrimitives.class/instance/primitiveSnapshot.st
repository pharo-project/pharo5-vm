system control primitives
primitiveSnapshot
	"save a normal snapshot under the same name as it was loaded unless it has been renamed by the last primitiveImageName"
	<inline: false>
	self snapshot: false
