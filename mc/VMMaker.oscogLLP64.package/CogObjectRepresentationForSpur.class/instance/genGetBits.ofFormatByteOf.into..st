compile abstract instructions
genGetBits: mask ofFormatByteOf: sourceReg into: destReg
	self flag: #endianness.
	cogit MoveMb: 3 r: sourceReg R: destReg.
	cogit AndCq: mask R: destReg.	"formatReg := self formatOfHeader: destReg"
	^0