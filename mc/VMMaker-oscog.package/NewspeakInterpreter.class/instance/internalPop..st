internal interpreter access
internalPop: nItems

	localSP := localSP - (nItems * BytesPerWord).