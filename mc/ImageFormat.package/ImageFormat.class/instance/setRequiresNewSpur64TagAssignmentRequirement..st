initialize-release
setRequiresNewSpur64TagAssignmentRequirement: aBoolean
	"Applicable only to 64-bit Spur images. If true, the updated tag assignment
	definitions are required. Earlier Spur 64 bit images use tag assignment for
	immediates that conflict with the Spur 32 bit image definition. "

	requiresNewSpur64TagAssignment := aBoolean
