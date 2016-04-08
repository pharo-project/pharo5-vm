compile abstract instructions
compileEntireFullBlockMethod
	"Compile the abstract instructions for the entire method, including blocks."
	| result |	
	self compileFullBlockEntry.

	"Frame build"
	self compileFullBlockMethodFrameBuild.
	"Method body"
	(result := self compileMethodBody) < 0 ifTrue:
		[^result].
	self assert: blockCount = 0.
	^0