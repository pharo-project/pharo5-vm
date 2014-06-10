md5
step1: w x: x y: y z: z data: data add: add shift: s
	"First step in MD5 transformation"
	| f result |
	f := z bitXor: (x bitAnd: (y bitXor: z)).
	result := w + f + data + add.
	result := self rotate: result by: s.
	^result + x bitAnd: 16rFFFFFFFF