combination rules
partitionedRgbComponentAlpha: sourceWord dest: destWord nBits: nBits nPartitions: nParts
	| mask result p1 p2 v |
	<returnTypeC: 'unsigned int'>
	<var: #sourceWord type: 'unsigned int'>
	<var: #destWord type: 'unsigned int'>
	<var: #p1 type: 'unsigned int'>
	<var: #p2 type: 'unsigned int'>
	<var: #mask type: 'unsigned int'>
	<var: #result type: 'unsigned int'>
	mask := maskTable at: nBits.  "partition mask starts at the right"
	result := 0.
	1 to: nParts do:
		[:i |
		p1 := (sourceWord bitAnd: mask) >> ((i - 1)*nBits).
		p2 := (destWord bitAnd: mask) >> ((i - 1)*nBits).
		nBits = 32
			ifFalse:[
				nBits = 16
					ifTrue:[
						p1 := (self rgbMap16To32: p1) bitOr: 16rFF000000.
						p2 := (self rgbMap16To32: p2) bitOr: 16rFF000000]
					ifFalse:[
						p1 := (self rgbMap: p1 from: nBits to: 32) bitOr: 16rFF000000.
						p2 := (self rgbMap: p2 from: nBits to: 32) bitOr: 16rFF000000.]].
		v := self rgbComponentAlpha32: p1 with: p2.
		nBits = 32
			ifFalse:[
				v := self rgbMap: v from: 32 to: nBits].
		result := result bitOr: (v <<  ((i - 1)*nBits)). 
		mask := mask << nBits  "slide left to next partition"].
	^ result
