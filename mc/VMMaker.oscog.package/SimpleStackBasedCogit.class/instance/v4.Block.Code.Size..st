span functions
v4: descriptor Block: pc Code: nExts Size: aMethodObj
	<var: #descriptor type: #'BytecodeDescriptor *'>
	"253		11111101 eei i i kkk	jjjjjjjj		Push Closure Num Copied iii (+ Ext A // 16 * 8) Num Args kkk (+ Ext A \\ 16 * 8) BlockSize jjjjjjjj (+ Ext B * 256). ee = num extensions"
	| byteOne extBValue |
	byteOne := objectMemory fetchByte: pc + 1 ofObject: aMethodObj.
	"If nExts < 0 it isn't known and we rely on the number of extensions encoded in the eeiiikkk byte."
	self assert: (nExts < 0 or: [nExts = (byteOne >> 6)]).
	self parseV4Exts: byteOne >> 6 priorTo: pc in: aMethodObj into: [:ea :eb| extBValue := eb].
	^(objectMemory fetchByte: pc + 2 ofObject: aMethodObj)
	+ (extBValue << 8)