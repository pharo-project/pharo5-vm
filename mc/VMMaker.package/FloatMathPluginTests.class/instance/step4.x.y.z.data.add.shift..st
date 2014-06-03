md5
step4: w x: x y: y z: z data: data add: add shift: s
	"First step in MD5 transformation"
	| f result |
	f := y bitXor: (x bitOr: (z  bitXor: 16rFFFFFFFF)).
	result := w + f + data + add.
	result := self rotate: result by: s.
	^result + x bitAnd: 16rFFFFFFFF