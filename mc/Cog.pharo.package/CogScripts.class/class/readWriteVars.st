separate vm scripts
readWriteVars
	^#(#specialObjectsOop
		#edenBytes #endOfMemory #forceTenureFlag #freeStart #needGCFlag
		#gcBiasToGrow #gcBiasToGrowGCLimit #gcBiasToGrowThreshold
		#growHeadroom #lastHash #lowSpaceThreshold #memory
		#remapBuffer #remapBufferCount #rootTable #rootTableCount
		#signalLowSpace #shrinkThreshold tenuringThreshold)