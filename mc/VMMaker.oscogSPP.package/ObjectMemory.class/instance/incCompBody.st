gc -- compaction
incCompBody
	"Move objects to consolidate free space into one big chunk. Return the newly created free chunk."

	| bytesFreed |
	<inline: false>
	"reserve memory for forwarding table"
	self fwdTableInit: self wordSize*2.  "Two-word blocks"

	"assign new oop locations, reverse their headers, and initialize forwarding blocks"
	bytesFreed := self incCompMakeFwd.

	"update pointers to point at new oops"
	self mapPointersInObjectsFrom: youngStart to: endOfMemory.

	"move the objects and restore their original headers; return the new free chunk"
	^ self incCompMove: bytesFreed