system primitives
primitiveMeasurementMetric
	"return a boolean specifying whether the currency symbol is pre or post fix. true -> pre"
	self primitive:'primitiveMeasurementMetric'.
	^self sqLocMeasurementMetric asOop: Boolean