compile abstract instructions
nextBytecodePCFor: descriptor exts: nExts
	<inline: true>
	<var: #descriptor type: #'BytecodeDescriptor *'>
	 ^ self nextBytecodePCFor: descriptor at: bytecodePC exts: nExts in: methodObj