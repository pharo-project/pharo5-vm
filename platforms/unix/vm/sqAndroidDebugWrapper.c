// function: perror
#include <stdio.h>
#include <errno.h>
// function: taggedPrint
#include <android/log.h>
// funtion of multiple size argument
#include <stdarg.h>
#include <jni.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

#define LOG_FILE "/sdcard/jni.log"

char logCache[1024];

int taggedPrint(const char *tag, const char *fmt, ...) {
  int result;
  va_list args;
  va_start(args, fmt);
  result = vaTaggedPrint(tag,fmt,args);
  va_end(args);
  return result;
}

int vaTaggedPrint(const char *tag, const char *fmt, va_list args) {
  int result;
  result = __android_log_vprint(ANDROID_LOG_INFO, tag, fmt, args);
	char str[2048];
	vsnprintf(str, 9999, fmt, args);
	jnilog(str);
  return result;
}

void *__real_warning(const char *s);
void *__wrap_warning(const char *s)
{
    taggedPrint("warning:", s);
	// doit for real
	__real_warning(s);
}

void *__real_puts(const char *s);
void *__wrap_puts(const char *s)
{
    taggedPrint("puts:", s);
	// doit for real
	__real_puts(s);
}

void *__real_perror(const char *s);
void *__wrap_perror (const char *s)
{
    taggedPrint("perror:", s);
	// doit for real
	__real_perror(s);
}

void *__real_error(const char *s);
void *__wrap_error (const char *s)
{
    taggedPrint("error:", s);
	// doit for real
	__real_error(s);
}

void *__real_printf(const char *s);
void *__wrap_printf(const char * format, ... )
{
	va_list a_list;
	va_start(a_list, format);
	vaTaggedPrint("printf", format, a_list);
	// can be usefull do it for real !!!
    vprintf(format, a_list);
	va_end(a_list);
}

void *__real_fprintf(FILE * stream, const char * format, ... );
void *__wrap_fprintf(FILE * stream, const char * format, ... )
{
	va_list a_list;
	char buf[50];
	
    char path[1024];
    char result[1024];
    int fd = fileno(stream); 
	   /* Read out the link to our file descriptor. */
    sprintf(path, "/proc/self/fd/%d", fd);
    memset(result, 0, sizeof(result));
    readlink(path, result, sizeof(result)-1);

    /* Print the result. */
	
	va_start(a_list, format);
	vaTaggedPrint(result, format, a_list);
	// can be usefull do it for real !!!
    vfprintf(stream,format, a_list);
	va_end(a_list);
}

char buffer[2048];
void *__real_fputs(char * value);
void *__wrap_fputs(char * value)
{	
	sprintf(buffer,"%s%s",buffer,value);
	// doit for real
	//__real_fputs(value);
}

void *__real_putchar(char value);
void *__wrap_putchar(char value)
{
	sprintf(buffer,"%s%c",buffer,value);
}

void *__real_fflush(FILE *stream);
void *__wrap_fflush(FILE *stream)
{
    taggedPrint("fflush:", buffer);
	buffer[0]=0;
	//memset(buffer,' ',2047);
	// doit for real
	//__real_fputs(value);
}

int printAndroidChar(char characterToPrint) {
	char logCacheTemp[64];
	sprintf(logCacheTemp, "%c", characterToPrint);
	return strcat(logCache,logCacheTemp);

}

int printAndroidHex(int longToPrint) {
	char logCacheTemp[64];
	sprintf(logCacheTemp, "%x", longToPrint);
	return strcat(logCache,logCacheTemp); 
}

int printAndroidUNum(int longToPrint) {
	char logCacheTemp[64];
	sprintf(logCacheTemp, "%u", longToPrint);
	return strcat(logCache,logCacheTemp); 
}


int printAndroidNum(int longToPrint) {
	char logCacheTemp[64];
	sprintf(logCacheTemp, "%d", longToPrint);
	return strcat(logCache,logCacheTemp); 
}

int printAndroidFloat(float floatToPrint) {
	char logCacheTemp[64];
	sprintf(logCacheTemp, "%d", floatToPrint);
	return strcat(logCache,logCacheTemp); 
}

int printAndroidString(char *charToPrint) {
	char logCacheTemp[100];
	sprintf(logCacheTemp, "%s", charToPrint);
	return strcat(logCache,logCacheTemp); 
}

void androidFlush(void) {
	sdprintf(logCache);
	sprintf(logCache, "");
	return;
}





