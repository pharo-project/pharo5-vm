/*
 * Initialize the VM here. In order to do this, call interp_init (formerly main) with
 * the zeroth argument pointing to the image plus some fake executable name. This will
 * give the VM an idea where the image is.
 */
#include <jni.h>
#include <android/log.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include "sqMemoryAccess.h"
#include "sqVirtualMachine.h"
#include <setjmp.h>	

#include <android/log.h>

#define LOG_FILE "/sdcard/jni.log"

#define MAXPATHLEN 256
#define NULL  (void*)0
extern struct VirtualMachine *interpreterProxy;
jmp_buf jmpBufEnter;
int scrw = 0, scrh = 0;

void jnilog(char *str) {
	int fd = open(LOG_FILE, O_RDWR | O_APPEND | O_CREAT, 0666);
	if(fd > -1) {
		int ms = ioMSecs();
		char msstr[50];
		snprintf(msstr, 49, "[%d] ", ms);
		write(fd, msstr, strlen(msstr));
		write(fd, str, strlen(str));
		close(fd);
	}
}

int sdprintf(const char *fmt, ...) {
  int result;
  va_list args;
  va_start(args, fmt);
  result = __android_log_vprint(ANDROID_LOG_INFO, "Smalltalk", fmt, args);
	char str[10000];
	vsnprintf(str, 9999, fmt, args);
	jnilog(str);
  va_end(args);
  return result;
}


int primNativeLog(char *fmt) {
    return sdprintf(fmt);
}

int Java_org_smalltalk_stack_StackVM_setScreenSize(JNIEnv *env, jobject self, int w, int h) {
  scrw = w;scrh = h;
  return 0;
}

int Java_org_smalltalk_stack_StackVM_setVMPath(JNIEnv *env, jobject self,jstring executablePath_, jstring imagePath_, jstring command_) {
  const char *exePath = (*env)->GetStringUTFChars(env, executablePath_, 0);
  const char *imgpath = (*env)->GetStringUTFChars(env, imagePath_, 0);
  const char *cmd = (*env)->GetStringUTFChars(env, command_, 0);
  int i,j,z,rc;

  int maximgarg = 128;
  char *imgargv[maximgarg];
  int imgargc = splitcmd(cmd, maximgarg, imgargv);
  
  int argl = 2 + imgargc + 1;
  char **argc = alloca(sizeof(char *) * argl);

  argc[0] = exePath;
  argc[1] = imgpath;
  i = 2;
  for(j = 0; j < imgargc; j++, i++) argc[i] = imgargv[j];
  argc[i] = NULL;
  char *envp[] = {NULL};
  
  rc = main(argl - 1, argc, envp);
  
  (*env)->ReleaseStringUTFChars(env, executablePath_, exePath);
  (*env)->ReleaseStringUTFChars(env, imagePath_, imgpath);
  (*env)->ReleaseStringUTFChars(env, command_, cmd);
  return rc;
}

int Java_org_smalltalk_stack_StackVM_updateDisplay(JNIEnv *env, jobject self,
					       jintArray bits, int w, int h,
					       int d, int left, int top, int right, int bottom) {

							   int row;
  sqInt formObj = interpreterProxy->displayObject();
  sqInt formBits = interpreterProxy->fetchPointerofObject(0, formObj);
  sqInt width = interpreterProxy->fetchIntegerofObject(1, formObj);
  sqInt height = interpreterProxy->fetchIntegerofObject(2, formObj);
  sqInt depth = interpreterProxy->fetchIntegerofObject(3, formObj);
  int *dispBits = interpreterProxy->firstIndexableField(formBits);
 for(row = top; row < bottom; row++) {
  	int ofs = width*row+left;
  	(*env)->SetIntArrayRegion(env, bits, ofs, right-left, dispBits+ofs);
  }
  return 1;
}

void Java_org_smalltalk_stack_StackVM_surelyExit(JNIEnv *env, jobject self) {
	exit(0);
}



void jumpOut(int reasonOfTheJumpOut) {
	longjmp(jmpBufEnter, reasonOfTheJumpOut);
}	

int runVM() {
    int reasonOfLeaving = setjmp(jmpBufEnter);
    
    sdprintf("runVM2");
	if (reasonOfLeaving == 0) {
     	printPhaseTime(2);
		interpret();
        sdprintf("interpret");
    }
	return reasonOfLeaving;
}

int splitcmd(char *cmd, int maxargc, char **argv) {
	char *argbuf = alloca(strlen(cmd) + 1);
	memset(argbuf, 0, strlen(cmd) + 1);
	int argc = 0;
	int inquote = 0, inarg = 0, inesc = 0;
	int argidx = 0;
	char *cptr;
	for(cptr = cmd; ; cptr++) {
		char c = *cptr;
		if(!c) break;
		if(argc >= maxargc) return argc;
		if(inesc) {
			argbuf[argidx++] = c;
			inesc = 0;
			continue;
		}
		if(c == '\\' && !inesc) {
			inesc = 1;
			continue;
		}
		if(c == '\"') {
			inquote = ~inquote;
			continue;
		}
                if(inquote) {
			argbuf[argidx++] = c;
			continue;
		}
		if((c == ' ' || c == '\t') && !inquote) {
			if(!strlen(argbuf)) continue;
			else {
				argv[argc] = strdup(argbuf);
				argc++;
				memset(argbuf, 0, strlen(cmd) + 1);
				argidx = 0;
			}
			continue;
		}
		argbuf[argidx++] = c;
	}
	if(strlen(argbuf)) {
		argv[argc] = strdup(argbuf);
		argc++;
	}
	return argc;
}