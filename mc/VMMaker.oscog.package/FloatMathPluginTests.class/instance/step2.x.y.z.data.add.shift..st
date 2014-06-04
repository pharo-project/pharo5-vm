md5
step2: w x: x y: y z: z data: data add: add shift: s
	"First step in MD5 transformation"
	| f result |
	f := y bitXor: (z bitAnd: (x bitXor: y)).
	result := w + f + data + add.
	result := self rotate: result by: s.
	^result + x bitAnd: 16rFFFFFFFF