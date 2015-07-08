C translation
generateSpurRemapOopIn: aNode on: aStream indent: level
	"Generate just the block argument for this message as Spur does not GC on allocation."

	aNode args second emitCCodeOn: aStream level: level generator: self