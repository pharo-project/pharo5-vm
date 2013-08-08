compile abstract instructions
genLoadSlot: index sourceReg: sourceReg destReg: destReg
	cogit MoveMw: index * BytesPerWord + BaseHeaderSize r: sourceReg R: destReg.
	^0