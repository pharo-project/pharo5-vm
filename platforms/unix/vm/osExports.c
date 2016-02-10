#define XFN(export) {"", #export, (void*)export},
#define XFN2(plugin, export) {#plugin, #export, (void*)plugin##_##export},

char * GetAttributeString(int id);
 

void *os_exports[][3]=
{
  XFN(GetAttributeString)
 
  { 0, 0, 0 }
};
