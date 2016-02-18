gc -- compaction
incCompBody
	"Move objects to consolidate free space into one big chunk. Return the newly created free chunk."

	| bytesToBeFreed |
	<inline: false>
	"reserve memory for forwarding table"
	self fwdTableInit: self wordSize*2.  "Two-word blocks"

	"assign new oop locations, reverse their headers, and initialize forwarding blocks"
	bytesToBeFreed := self incCompMakeFwd.

	"update pointers to point at new oops"
	self mapPointersInObjectsFrom: youngStart to: freeStart.

	"move the objects and restore their original headers; return the new free chunk"
	^self incCompMove: bytesToBeFreed