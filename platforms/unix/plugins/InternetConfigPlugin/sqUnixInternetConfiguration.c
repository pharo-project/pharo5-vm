#include <dlfcn.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

static void* gconf_handle;
void* (*get_client)(void);
char* (*get_string)(void*,char*,void*);
int   (*get_int)   (void*,char*,void*);
int   (*get_bool)   (void*,char*,void*);

/*********************** INITIALIZATION ***************************/

int sqInternetConfigurationInit() {
    void (*init)(void);
    gconf_handle = dlopen ("libgconf-2.so", RTLD_LAZY);
    if (!gconf_handle) {
        fprintf (stdout, "%s\n", dlerror());
    }else{
        init = dlsym(gconf_handle, "g_type_init");
        init();
        get_client = dlsym(gconf_handle, "gconf_client_get_default");
        get_string = dlsym(gconf_handle, "gconf_client_get_string");
        get_int = dlsym(gconf_handle, "gconf_client_get_int");
        get_bool = dlsym(gconf_handle, "gconf_client_get_bool");
    }
	return 1;
}

/*********************** END INITIALIZATION ***************************/

/*********************** AUXILIAR - GConf and Environment ***************************/

#define equals(some_string, other_string) !strcmp(some_string,other_string)
#define empty(some_string) equals(some_string, "\0")

void checkEnvironmentAndFill(char* string_to_fill, char* key, int key_length, char* property_key, char* env_var){
    char has_property_key[255];
    char get_property_key[255];
    char* env_value = getenv(env_var);

    sprintf(has_property_key, "Use%sProxy", property_key);
    sprintf(get_property_key, "%sProxyHost", property_key);
    if (strncmp(has_property_key, key, key_length) == 0){
        strcpy(string_to_fill, env_value? "1" : "0");
    } else if (strncmp(get_property_key, key, key_length) == 0){
        strcpy(string_to_fill, env_value? env_value : "\0");
    }
}

void checkGConfAndFill(void* client, char* string_to_fill, char* key, int key_length, char* property_key, char* host_key, char* port_key){
    char has_property_key[255];
    char get_property_key[255];
    sprintf(has_property_key, "Use%sProxy", property_key);
    sprintf(get_property_key, "%sProxyHost", property_key);
    if (strncmp(has_property_key, key, key_length) == 0){
        int use_proxy = !empty(get_string(client, host_key, NULL));
        printf("use proxy: %d\n", use_proxy);
        strcpy(string_to_fill, use_proxy? "1" : "0");
    } else if (strncmp(get_property_key, key, key_length) == 0){
        sprintf(
            string_to_fill,
            "%s://%s:%d",
            property_key,
            get_string(client, host_key, NULL),
            get_int(client, port_key, NULL)
        );
    }
}

#undef empty


void getSettingFromGConfInto(char* string_to_fill, char* key, int key_length){
    void *client = get_client();
    if (!get_bool(client, "/system/http_proxy/use_http_proxy", NULL)
            && !equals("manual", get_string(client, "/system/proxy/mode", NULL))){
        return;
    }
    if (get_bool(client, "/system/http_proxy/use_same_proxy", NULL)){ /* We check the 4 protocols using the same settings */
        checkGConfAndFill(client, string_to_fill, key, key_length, "HTTP",   "/system/http_proxy/host",  "/system/http_proxy/port");
        checkGConfAndFill(client, string_to_fill, key, key_length, "HTTPS",  "/system/http_proxy/host",  "/system/http_proxy/port");
        checkGConfAndFill(client, string_to_fill, key, key_length, "FTP",    "/system/http_proxy/host",  "/system/http_proxy/port");
        checkGConfAndFill(client, string_to_fill, key, key_length, "SOCKS",  "/system/http_proxy/host",  "/system/http_proxy/port");
    } else { /* Each one looks for it's settings */
        checkGConfAndFill(client, string_to_fill, key, key_length, "HTTP",   "/system/http_proxy/host",  "/system/http_proxy/port");
        checkGConfAndFill(client, string_to_fill, key, key_length, "HTTPS",  "/system/proxy/secure_host","/system/proxy/secure_port");
        checkGConfAndFill(client, string_to_fill, key, key_length, "FTP",    "/system/proxy/ftp_host",   "/system/proxy/ftp_port");
        checkGConfAndFill(client, string_to_fill, key, key_length, "SOCKS",  "/system/proxy/socks_host", "/system/proxy/socks_port");
    }
}

#undef equals

void getSettingFromEnvironmentInto(char* string_to_fill, char* key, int key_length){
    checkEnvironmentAndFill(string_to_fill, key, key_length , "HTTP", "http_proxy");
    checkEnvironmentAndFill(string_to_fill, key, key_length, "HTTPS", "http_proxy");
    checkEnvironmentAndFill(string_to_fill, key, key_length, "FTP", "ftp_proxy");
}

/*********************** END AUXILIAR - GConf and Environment ***************************/

/*********************** Main Plugin Entry Points ***************************/

int sqInternetConfigurationGetStringKeyedBykeySizeinto(char *key,int keyLength, char *string_to_fill) {
    if (gconf_handle){
        getSettingFromGConfInto(string_to_fill, key, keyLength);
    }else{
        getSettingFromEnvironmentInto(string_to_fill, key, keyLength);
    }
    return strlen(string_to_fill);
}

void sqInternetGetMacintoshFileTypeAndCreatorFromkeySizeinto(char * aFileName, int keyLength, char * creator){
    /* Y U KEEPING ME? */
}

/*********************** END Main Plugin Entry Points ***************************/

/*********************** SHUTDOWN ***************************/

int sqInternetConfigurationShutdown(){
    if (gconf_handle) dlclose(gconf_handle);
    return 1;
}

/*********************** END SHUTDOWN ***************************/
