#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#include <dlfcn.h>

#define ASM(...) __asm__(#__VA_ARGS__)
// ldr x8, value; br x8; value: .ascii "\x41\x42\x43\x44\x45\x46\x47\x48"
static char patch[] = {0x88,0x00,0x00,0x58,0x00,0x01,0x1f,0xd6,0x1f,0x20,0x03,0xd5,0x1f,0x20,0x03,0xd5,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41};

// Since we're patching libsystem_kernel, we must avoid calling to its functions
static void builtin_memcpy(char *target, char *source, size_t size) {
    for (int i = 0; i < size; i++) {
        target[i] = source[i];
    }
}

// Originated from _kernelrpc_mach_vm_protect_trap
kern_return_t builtin_vm_protect(mach_port_name_t task, mach_vm_address_t address, mach_vm_size_t size, boolean_t set_max, vm_prot_t new_prot);
ASM(
.global _builtin_vm_protect \n
_builtin_vm_protect:     \n
    mov x16, #-0xe       \n
    svc #0x80            \n
    ret
);

static void redirectFunction(void *patchAddr, void *target) {
    kern_return_t kret = builtin_vm_protect(mach_task_self(), (vm_address_t)patchAddr, sizeof(patch), false, PROT_READ | PROT_WRITE | VM_PROT_COPY);
    assert(kret == KERN_SUCCESS);
    
    builtin_memcpy((char *)patchAddr, patch, sizeof(patch));
    *(void **)((char*)patchAddr + 16) = target;
    
    kret = builtin_vm_protect(mach_task_self(), (vm_address_t)patchAddr, sizeof(patch), false, PROT_READ | PROT_EXEC);
    assert(kret == KERN_SUCCESS);
}

extern BOOL BSSelfTaskHasEntitlement(NSString *ent);
extern uint32_t SecTaskGetCodeSignStatus(uint64_t task);

BOOL hook_BSSelfTaskHasEntitlement(NSString *ent) {
    return YES;
}
uint32_t hook_SecTaskGetCodeSignStatus(uint64_t task) {
    return 0x36803809;
}

void showDialog(UIViewController *viewController, NSString* title, NSString* message) {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
        message:message
        preferredStyle:UIAlertControllerStyleAlert];
    //text.dataDetectorTypes = UIDataDetectorTypeLink;
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];

    [viewController presentViewController:alert animated:YES completion:nil];
}

int main(int argc, char **argv) {
    @autoreleasepool {
        // TODO: use Ellekit JITless hook
        redirectFunction((void *)BSSelfTaskHasEntitlement, (void *)hook_BSSelfTaskHasEntitlement);
        redirectFunction((void *)SecTaskGetCodeSignStatus, (void *)hook_SecTaskGetCodeSignStatus);
        dlopen("@executable_path/DynamicPlaygroundLib.dylib", RTLD_LAZY);
        return UIApplicationMain(argc, argv, nil, @"AppDelegate");
    };
}
