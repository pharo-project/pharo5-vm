private
recordMovementOf: o to: toFinger savedFirstFieldPtr: savedFirstFieldPtr
	relocationMap ifNotNil: [:rm| rm at: o put: savedFirstFieldPtr]