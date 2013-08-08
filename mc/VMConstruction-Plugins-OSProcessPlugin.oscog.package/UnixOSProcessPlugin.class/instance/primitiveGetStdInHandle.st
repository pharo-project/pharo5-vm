primitives - files
primitiveGetStdInHandle
	"Answer the file handle for standard input of my OS process"
	<export: true>
	self getStdHandle: 0
