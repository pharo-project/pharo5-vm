plugin-testing
pluginPrepareData
	"The FFT plugin requires data to be represented in WordArrays or FloatArrays"
	sinTable := sinTable asFloatArray.
	permTable := permTable asWordArray.
	realData := realData asFloatArray.
	imagData := imagData asFloatArray.