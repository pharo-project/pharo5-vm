compile abstract instructions
isBackwardBranch: descriptor at: pc exts: nExts in: aMethodObj
	"Answer if the branch bytecode with the given descriptor is a backward branch."
	<inline: true>
	<var: #descriptor type: #'BytecodeDescriptor *'>
	self assert: descriptor spanFunction notNil.
	^(self
		perform: descriptor spanFunction
		with: descriptor
		with: pc
		with: nExts
		with: aMethodObj) < 0