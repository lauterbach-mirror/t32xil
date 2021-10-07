/*
 * Copyright 2016-2017 The MathWorks, Inc.
 */

#ifndef _DIAB_BUILTINS_POWERPC_H_
#define _DIAB_BUILTINS_POWERPC_H_

/*
   Intrinsic Functions, see Section 8.6 of the Wind River Diab for PowerPC 5.9 manual.
   This header only declares functions not declared in <diab>/include/diab/ppcasm.h
*/

#if defined(__TMW_COMPILER_DIAB__) && defined(__TMW_TARGET_POWERPC__)

/* DISABLED--- 
PST_LINK_C void *__alloca(unsigned int);
*/

#if defined(__TMW_DIAB_POWERPC_INTRINSIC_MASK__) && (__TMW_DIAB_POWERPC_INTRINSIC_MASK__ & 0x800000)

/*DISABLED--- 
PST_LINK_C void *alloca(unsigned int);
*/
#endif

#if defined(__TMW_DIAB_POWERPC_INTRINSIC_MASK__) && (__TMW_DIAB_POWERPC_INTRINSIC_MASK__ & 0x400000)
/* __builtin_expect
   ----------------
   We provide an implementation for this function that allows Polyspace to fully analyze
   (no stub).
*/
#define __builtin_expect(exp,c) (exp)

/* __builtin_prefetch
   ------------------
   We provide an implementation for this function that allows Polyspace to fully analyze
   (no stub).
*/
#define __builtin_prefetch(...) do{}while(0)
#endif

#if defined(__TMW_DIAB_POWERPC_INTRINSIC_MASK__) && (__TMW_DIAB_POWERPC_INTRINSIC_MASK__ & 0x1)
PST_LINK_C unsigned int __ff0(unsigned int);
PST_LINK_C unsigned int __ff0ll(unsigned long long);
PST_LINK_C unsigned int __ff1(unsigned int);
PST_LINK_C unsigned int __ff1ll(unsigned long long);
#endif

#if defined(__TMW_DIAB_POWERPC_INTRINSIC_MASK__) && (__TMW_DIAB_POWERPC_INTRINSIC_MASK__ & 0x2)
PST_LINK_C unsigned int __fpscr(void);
#endif

#if defined(__TMW_DIAB_POWERPC_INTRINSIC_MASK__) && (__TMW_DIAB_POWERPC_INTRINSIC_MASK__ & 0x40)
PST_LINK_C void __wait(void);
#endif

#ifndef __skip_ansi_vararg_prototypes
#ifndef __cplusplus
extern int printf(const char *, ...);
extern int scanf(const char *, ...);
extern int sprintf(char *, const char *, ...);
extern int sscanf(const char *, const char *, ...);
#endif /* __cplusplus */
#endif /* __skip_ansi_vararg_prototypes */

#if 0 /* DISABLED--- The PPCE200Z0VES conflicts with these intrinsics (WindRiver Diab bug) */
#ifdef __SPE__

int __ev_get_spefscr_sovh();
int __ev_get_spefscr_ovh();
int __ev_get_spefscr_fgh();
int __ev_get_spefscr_fxh();
int __ev_get_spefscr_finvh();
int __ev_get_spefscr_fdbzh();
int __ev_get_spefscr_funfh();
int __ev_get_spefscr_fovfh();
int __ev_get_spefscr_finxs();
int __ev_get_spefscr_finvs();
int __ev_get_spefscr_fdbzs();
int __ev_get_spefscr_funfs();
int __ev_get_spefscr_fovfs();
int __ev_get_spefscr_mode();
int __ev_get_spefscr_sov();
int __ev_get_spefscr_ov();
int __ev_get_spefscr_fg();
int __ev_get_spefscr_fx();
int __ev_get_spefscr_finv();
int __ev_get_spefscr_fdbz();
int __ev_get_spefscr_funf();
int __ev_get_spefscr_fovf();
int __ev_get_spefscr_finxe();
int __ev_get_spefscr_finve();
int __ev_get_spefscr_fdbze();
int __ev_get_spefscr_funfe();
int __ev_get_spefscr_fovfe();
int __ev_get_spefscr_frmc();
void __ev_clr_spefscr_sovh();
void __ev_clr_spefscr_finxs();
void __ev_clr_spefscr_finvs();
void __ev_clr_spefscr_fdbzs();
void __ev_clr_spefscr_funfs();
void __ev_clr_spefscr_fovfs();
void __ev_clr_spefscr_sov();
float __ev_get_sfix32_fs(__ev64_opaque__, unsigned int);
float __ev_get_ufix32_fs(__ev64_opaque__, unsigned int);
float __ev_get_lower_sfix32_fs(__ev64_opaque__);
float __ev_get_lower_ufix32_fs(__ev64_opaque__);
float __ev_get_upper_sfix32_fs(__ev64_opaque__);
float __ev_get_upper_ufix32_fs(__ev64_opaque__);
__ev64_opaque__ __ev_set_sfix32_fs(__ev64_opaque__, float, unsigned int);
__ev64_opaque__ __ev_set_ufix32_fs(__ev64_opaque__, float, unsigned int);
__ev64_opaque__ __ev_create_sfix32_fs(float, float);
__ev64_opaque__ __ev_create_ufix32_fs(float, float);
__ev64_opaque__ __ev_create_s16(short, short, short, short);
__ev64_opaque__ __ev_create_u16(unsigned short, unsigned short, unsigned short, unsigned short);
__ev64_opaque__ __ev_create_s32(int, int);
__ev64_opaque__ __ev_create_sfix32_s32(float, float);
__ev64_opaque__ __ev_create_u32(unsigned int, unsigned int);
__ev64_opaque__ __ev_create_ufix32_u32(float, float);
int __ev_get_lower_s32(__ev64_opaque__);
int __ev_get_lower_sfix32_s32(__ev64_opaque__);
unsigned int __ev_get_lower_u32(__ev64_opaque__);
unsigned int __ev_get_lower_ufix32_u32(__ev64_opaque__);
int __ev_get_upper_s32(__ev64_opaque__);
int __ev_get_upper_sfix32_s32(__ev64_opaque__);
unsigned int __ev_get_upper_u32(__ev64_opaque__);
unsigned int __ev_get_upper_ufix32_u32(__ev64_opaque__);
int __ev_get_spefscr_fdbz();
int __ev_get_spefscr_fdbze();
int __ev_get_spefscr_fdbzh();
int __ev_get_spefscr_fdbzs();
int __ev_get_spefscr_fg();
int __ev_get_spefscr_fgh();
int __ev_get_spefscr_finv();
int __ev_get_spefscr_finve();
int __ev_get_spefscr_finvh();
int __ev_get_spefscr_finvs();
int __ev_get_spefscr_finxe();
int __ev_get_spefscr_finxs();
int __ev_get_spefscr_fovf();
int __ev_get_spefscr_fovfe();
int __ev_get_spefscr_fovfh();
int __ev_get_spefscr_fovfs();
int __ev_get_spefscr_frmc();
int __ev_get_spefscr_funf();
int __ev_get_spefscr_funfe();
int __ev_get_spefscr_funfh();
int __ev_get_spefscr_funfs();
int __ev_get_spefscr_fx();
int __ev_get_spefscr_fxh();
int __ev_get_spefscr_mode();
int __ev_get_spefscr_ov();
int __ev_get_spefscr_ovh();
int __ev_get_spefscr_sov();
int __ev_get_spefscr_sovh();
void __ev_clr_spefscr_fdbzs();
void __ev_clr_spefscr_finvs();
void __ev_clr_spefscr_finxs();
void __ev_clr_spefscr_fovfs();
void __ev_clr_spefscr_funfs();
void __ev_clr_spefscr_sov();
void __ev_clr_spefscr_sovh();
void __ev_set_spefscr_frmc(unsigned int);
__ev64_opaque__ __ev_create_s64(int);
__ev64_opaque__ __ev_create_u64(unsigned int);
__ev64_opaque__ __ev_set_acc_u64(unsigned int);
__ev64_opaque__ __ev_set_acc_s64(int);
__ev64_opaque__ __ev_set_acc_vec64(__ev64_opaque__);
__ev64_opaque__ __ev_create_fs(float, float);
__ev64_opaque__ __ev_create_sfix32_fs(float, float);
__ev64_opaque__ __ev_create_ufix32_fs(float, float);
__ev64_opaque__ __ev_set_fs(__ev64_opaque__, float, unsigned int);
__ev64_opaque__ __ev_set_sfix32_fs(__ev64_opaque__, float, unsigned int);
__ev64_opaque__ __ev_set_ufix32_fs(__ev64_opaque__, float, unsigned int);
__ev64_opaque__ __ev_set_s32(__ev64_opaque__, int, unsigned int);
__ev64_opaque__ __ev_set_sfix32_s32(__ev64_opaque__, int, unsigned int);
__ev64_opaque__ __ev_set_u32(__ev64_opaque__, unsigned int, unsigned int);
__ev64_opaque__ __ev_set_ufix32_u32(__ev64_opaque__, unsigned int, unsigned int);
float __ev_get_fs(__ev64_opaque__, unsigned int);
float __ev_get_sfix32_fs(__ev64_opaque__, unsigned int);
float __ev_get_ufix32_fs(__ev64_opaque__, unsigned int);
float __ev_get_lower_sfix32_fs(__ev64_opaque__);
float __ev_get_lower_ufix32_fs(__ev64_opaque__);
float __ev_get_upper_sfix32_fs(__ev64_opaque__);
float __ev_get_upper_ufix32_fs(__ev64_opaque__);
int __ev_get_s32(__ev64_opaque__, unsigned int);
unsigned int __ev_get_u32(__ev64_opaque__, unsigned int);
int __ev_get_sfix32_s32(__ev64_opaque__, unsigned int);
unsigned int __ev_get_ufix32_u32(__ev64_opaque__, unsigned int);
long long __ev_convert_s64(__ev64_opaque__);
unsigned long long __ev_convert_u64(__ev64_opaque__);

// Note: the following intrinsics don't work with dcc (internal compiler error (etoa:1600): No table entry found!)
__ev64_opaque__ __ev_set_lower_sfix32_fs(__ev64_opaque__, float);
__ev64_opaque__ __ev_set_lower_ufix32_fs(__ev64_opaque__, float);
__ev64_opaque__ __ev_set_upper_sfix32_fs(__ev64_opaque__, float);
__ev64_opaque__ __ev_set_upper_ufix32_fs(__ev64_opaque__, float);
__ev64_opaque__ __ev_set_lower_fs(__ev64_opaque__, float);
__ev64_opaque__ __ev_set_lower_sfix32_fs(__ev64_opaque__, float);
__ev64_opaque__ __ev_set_lower_ufix32_fs(__ev64_opaque__, float);
__ev64_opaque__ __ev_set_upper_fs(__ev64_opaque__, float);
__ev64_opaque__ __ev_set_upper_sfix32_fs(__ev64_opaque__, float);
__ev64_opaque__ __ev_set_upper_ufix32_fs(__ev64_opaque__, float);

// Note: the following intrinsics don't work with dcc (fatal error (etoa:1573): compiler error in ppc_vle.nd -- trying to use F reg)
float __ev_get_lower_fs(__ev64_opaque__);
float __ev_get_upper_fs(__ev64_opaque__);

#endif /* __SPE__ */
#endif

#endif /* __TMW_COMPILER_DIAB__ && __TMW_TARGET_POWERPC__ */

#endif /* _DIAB_BUILTINS_POWERPC_H_ */
