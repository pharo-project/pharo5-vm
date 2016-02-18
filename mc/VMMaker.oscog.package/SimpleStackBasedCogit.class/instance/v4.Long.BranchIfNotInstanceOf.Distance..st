span functions
v4: descriptor Long: pc BranchIfNotInstanceOf: nExts Distance: aMethodObj
	"**	254		11111110	kkkkkkkk	jjjjjjjj		branch If Not Instance Of Behavior/Array Of Behavior kkkkkkkk (+ Extend A * 256, where Extend A >= 0) distance jjjjjjjj (+ Extend B * 256, where Extend B >= 0)"
	<var: #descriptor type: #'BytecodeDescriptor *'>
	| extBValue |
	self assert: nExts >= 0.
	self parseV4Exts: nExts priorTo: pc in: aMethodObj into: [:ea :eb| extBValue := eb].
	^(objectMemory fetchByte: pc + 2 ofObject: aMethodObj) + (extBValue << 8)