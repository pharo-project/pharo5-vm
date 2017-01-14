callout support
isCalleePopsConvention: callType
	<cmacro: '(callType) (PLATFORM_API_USES_CALLEE_POPS_CONVENTION && (callType) == FFICallTypeApi)'>
	^callType == FFICallTypeApi