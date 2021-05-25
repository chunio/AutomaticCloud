/*** Autogenerated by WIDL 1.9.0 from iextag.idl - Do not edit ***/

#ifndef __REQUIRED_RPCNDR_H_VERSION__
#define __REQUIRED_RPCNDR_H_VERSION__ 475
#endif

#include <rpc.h>
#include <rpcndr.h>

#ifndef COM_NO_WINDOWS_H
#include <windows.h>
#include <ole2.h>
#endif

#ifndef __iextag_h__
#define __iextag_h__

/* Forward declarations */

#ifndef __IClientCaps_FWD_DEFINED__
#define __IClientCaps_FWD_DEFINED__
typedef interface IClientCaps IClientCaps;
#ifdef __cplusplus
interface IClientCaps;
#endif /* __cplusplus */
#endif

#ifndef __ClientCaps_FWD_DEFINED__
#define __ClientCaps_FWD_DEFINED__
#ifdef __cplusplus
typedef class ClientCaps ClientCaps;
#else
typedef struct ClientCaps ClientCaps;
#endif /* defined __cplusplus */
#endif /* defined __ClientCaps_FWD_DEFINED__ */

/* Headers for imported files */

#include <oaidl.h>
#include <ocidl.h>

#ifdef __cplusplus
extern "C" {
#endif

/*****************************************************************************
 * IClientCaps interface
 */
#ifndef __IClientCaps_INTERFACE_DEFINED__
#define __IClientCaps_INTERFACE_DEFINED__

DEFINE_GUID(IID_IClientCaps, 0x7e8bc44d, 0xaeff, 0x11d1, 0x89,0xc2, 0x00,0xc0,0x4f,0xb6,0xbf,0xc4);
#if defined(__cplusplus) && !defined(CINTERFACE)
MIDL_INTERFACE("7e8bc44d-aeff-11d1-89c2-00c04fb6bfc4")
IClientCaps : public IDispatch
{
    virtual HRESULT STDMETHODCALLTYPE get_javaEnabled(
        VARIANT_BOOL *pVal) = 0;

    virtual HRESULT STDMETHODCALLTYPE get_cookieEnabled(
        VARIANT_BOOL *pVal) = 0;

    virtual HRESULT STDMETHODCALLTYPE get_cpuClass(
        BSTR *p) = 0;

    virtual HRESULT STDMETHODCALLTYPE get_systemLanguage(
        BSTR *p) = 0;

    virtual HRESULT STDMETHODCALLTYPE get_userLanguage(
        BSTR *p) = 0;

    virtual HRESULT STDMETHODCALLTYPE get_platform(
        BSTR *p) = 0;

    virtual HRESULT STDMETHODCALLTYPE get_connectionSpeed(
        LONG *p) = 0;

    virtual HRESULT STDMETHODCALLTYPE get_onLine(
        VARIANT_BOOL *p) = 0;

    virtual HRESULT STDMETHODCALLTYPE get_colorDepth(
        LONG *p) = 0;

    virtual HRESULT STDMETHODCALLTYPE get_bufferDepth(
        LONG *p) = 0;

    virtual HRESULT STDMETHODCALLTYPE get_width(
        LONG *p) = 0;

    virtual HRESULT STDMETHODCALLTYPE get_height(
        LONG *p) = 0;

    virtual HRESULT STDMETHODCALLTYPE get_availHeight(
        LONG *p) = 0;

    virtual HRESULT STDMETHODCALLTYPE get_availWidth(
        LONG *p) = 0;

    virtual HRESULT STDMETHODCALLTYPE get_connectionType(
        BSTR *p) = 0;

    virtual HRESULT STDMETHODCALLTYPE isComponentInstalled(
        BSTR bstrName,
        BSTR bstrType,
        BSTR bStrVer,
        VARIANT_BOOL *p) = 0;

    virtual HRESULT STDMETHODCALLTYPE getComponentVersion(
        BSTR bstrName,
        BSTR bstrType,
        BSTR *pbstrVer) = 0;

    virtual HRESULT STDMETHODCALLTYPE compareVersions(
        BSTR bstrVer1,
        BSTR bstrVer2,
        LONG *p) = 0;

    virtual HRESULT STDMETHODCALLTYPE addComponentRequest(
        BSTR bstrName,
        BSTR bstrType,
        BSTR bstrVer = L"") = 0;

    virtual HRESULT STDMETHODCALLTYPE doComponentRequest(
        VARIANT_BOOL *p) = 0;

    virtual HRESULT STDMETHODCALLTYPE clearComponentRequest(
        ) = 0;

};
#ifdef __CRT_UUID_DECL
__CRT_UUID_DECL(IClientCaps, 0x7e8bc44d, 0xaeff, 0x11d1, 0x89,0xc2, 0x00,0xc0,0x4f,0xb6,0xbf,0xc4)
#endif
#else
typedef struct IClientCapsVtbl {
    BEGIN_INTERFACE

    /*** IUnknown methods ***/
    HRESULT (STDMETHODCALLTYPE *QueryInterface)(
        IClientCaps *This,
        REFIID riid,
        void **ppvObject);

    ULONG (STDMETHODCALLTYPE *AddRef)(
        IClientCaps *This);

    ULONG (STDMETHODCALLTYPE *Release)(
        IClientCaps *This);

    /*** IDispatch methods ***/
    HRESULT (STDMETHODCALLTYPE *GetTypeInfoCount)(
        IClientCaps *This,
        UINT *pctinfo);

    HRESULT (STDMETHODCALLTYPE *GetTypeInfo)(
        IClientCaps *This,
        UINT iTInfo,
        LCID lcid,
        ITypeInfo **ppTInfo);

    HRESULT (STDMETHODCALLTYPE *GetIDsOfNames)(
        IClientCaps *This,
        REFIID riid,
        LPOLESTR *rgszNames,
        UINT cNames,
        LCID lcid,
        DISPID *rgDispId);

    HRESULT (STDMETHODCALLTYPE *Invoke)(
        IClientCaps *This,
        DISPID dispIdMember,
        REFIID riid,
        LCID lcid,
        WORD wFlags,
        DISPPARAMS *pDispParams,
        VARIANT *pVarResult,
        EXCEPINFO *pExcepInfo,
        UINT *puArgErr);

    /*** IClientCaps methods ***/
    HRESULT (STDMETHODCALLTYPE *get_javaEnabled)(
        IClientCaps *This,
        VARIANT_BOOL *pVal);

    HRESULT (STDMETHODCALLTYPE *get_cookieEnabled)(
        IClientCaps *This,
        VARIANT_BOOL *pVal);

    HRESULT (STDMETHODCALLTYPE *get_cpuClass)(
        IClientCaps *This,
        BSTR *p);

    HRESULT (STDMETHODCALLTYPE *get_systemLanguage)(
        IClientCaps *This,
        BSTR *p);

    HRESULT (STDMETHODCALLTYPE *get_userLanguage)(
        IClientCaps *This,
        BSTR *p);

    HRESULT (STDMETHODCALLTYPE *get_platform)(
        IClientCaps *This,
        BSTR *p);

    HRESULT (STDMETHODCALLTYPE *get_connectionSpeed)(
        IClientCaps *This,
        LONG *p);

    HRESULT (STDMETHODCALLTYPE *get_onLine)(
        IClientCaps *This,
        VARIANT_BOOL *p);

    HRESULT (STDMETHODCALLTYPE *get_colorDepth)(
        IClientCaps *This,
        LONG *p);

    HRESULT (STDMETHODCALLTYPE *get_bufferDepth)(
        IClientCaps *This,
        LONG *p);

    HRESULT (STDMETHODCALLTYPE *get_width)(
        IClientCaps *This,
        LONG *p);

    HRESULT (STDMETHODCALLTYPE *get_height)(
        IClientCaps *This,
        LONG *p);

    HRESULT (STDMETHODCALLTYPE *get_availHeight)(
        IClientCaps *This,
        LONG *p);

    HRESULT (STDMETHODCALLTYPE *get_availWidth)(
        IClientCaps *This,
        LONG *p);

    HRESULT (STDMETHODCALLTYPE *get_connectionType)(
        IClientCaps *This,
        BSTR *p);

    HRESULT (STDMETHODCALLTYPE *isComponentInstalled)(
        IClientCaps *This,
        BSTR bstrName,
        BSTR bstrType,
        BSTR bStrVer,
        VARIANT_BOOL *p);

    HRESULT (STDMETHODCALLTYPE *getComponentVersion)(
        IClientCaps *This,
        BSTR bstrName,
        BSTR bstrType,
        BSTR *pbstrVer);

    HRESULT (STDMETHODCALLTYPE *compareVersions)(
        IClientCaps *This,
        BSTR bstrVer1,
        BSTR bstrVer2,
        LONG *p);

    HRESULT (STDMETHODCALLTYPE *addComponentRequest)(
        IClientCaps *This,
        BSTR bstrName,
        BSTR bstrType,
        BSTR bstrVer);

    HRESULT (STDMETHODCALLTYPE *doComponentRequest)(
        IClientCaps *This,
        VARIANT_BOOL *p);

    HRESULT (STDMETHODCALLTYPE *clearComponentRequest)(
        IClientCaps *This);

    END_INTERFACE
} IClientCapsVtbl;

interface IClientCaps {
    CONST_VTBL IClientCapsVtbl* lpVtbl;
};

#ifdef COBJMACROS
#ifndef WIDL_C_INLINE_WRAPPERS
/*** IUnknown methods ***/
#define IClientCaps_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IClientCaps_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IClientCaps_Release(This) (This)->lpVtbl->Release(This)
/*** IDispatch methods ***/
#define IClientCaps_GetTypeInfoCount(This,pctinfo) (This)->lpVtbl->GetTypeInfoCount(This,pctinfo)
#define IClientCaps_GetTypeInfo(This,iTInfo,lcid,ppTInfo) (This)->lpVtbl->GetTypeInfo(This,iTInfo,lcid,ppTInfo)
#define IClientCaps_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) (This)->lpVtbl->GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)
#define IClientCaps_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) (This)->lpVtbl->Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)
/*** IClientCaps methods ***/
#define IClientCaps_get_javaEnabled(This,pVal) (This)->lpVtbl->get_javaEnabled(This,pVal)
#define IClientCaps_get_cookieEnabled(This,pVal) (This)->lpVtbl->get_cookieEnabled(This,pVal)
#define IClientCaps_get_cpuClass(This,p) (This)->lpVtbl->get_cpuClass(This,p)
#define IClientCaps_get_systemLanguage(This,p) (This)->lpVtbl->get_systemLanguage(This,p)
#define IClientCaps_get_userLanguage(This,p) (This)->lpVtbl->get_userLanguage(This,p)
#define IClientCaps_get_platform(This,p) (This)->lpVtbl->get_platform(This,p)
#define IClientCaps_get_connectionSpeed(This,p) (This)->lpVtbl->get_connectionSpeed(This,p)
#define IClientCaps_get_onLine(This,p) (This)->lpVtbl->get_onLine(This,p)
#define IClientCaps_get_colorDepth(This,p) (This)->lpVtbl->get_colorDepth(This,p)
#define IClientCaps_get_bufferDepth(This,p) (This)->lpVtbl->get_bufferDepth(This,p)
#define IClientCaps_get_width(This,p) (This)->lpVtbl->get_width(This,p)
#define IClientCaps_get_height(This,p) (This)->lpVtbl->get_height(This,p)
#define IClientCaps_get_availHeight(This,p) (This)->lpVtbl->get_availHeight(This,p)
#define IClientCaps_get_availWidth(This,p) (This)->lpVtbl->get_availWidth(This,p)
#define IClientCaps_get_connectionType(This,p) (This)->lpVtbl->get_connectionType(This,p)
#define IClientCaps_isComponentInstalled(This,bstrName,bstrType,bStrVer,p) (This)->lpVtbl->isComponentInstalled(This,bstrName,bstrType,bStrVer,p)
#define IClientCaps_getComponentVersion(This,bstrName,bstrType,pbstrVer) (This)->lpVtbl->getComponentVersion(This,bstrName,bstrType,pbstrVer)
#define IClientCaps_compareVersions(This,bstrVer1,bstrVer2,p) (This)->lpVtbl->compareVersions(This,bstrVer1,bstrVer2,p)
#define IClientCaps_addComponentRequest(This,bstrName,bstrType,bstrVer) (This)->lpVtbl->addComponentRequest(This,bstrName,bstrType,bstrVer)
#define IClientCaps_doComponentRequest(This,p) (This)->lpVtbl->doComponentRequest(This,p)
#define IClientCaps_clearComponentRequest(This) (This)->lpVtbl->clearComponentRequest(This)
#else
/*** IUnknown methods ***/
static FORCEINLINE HRESULT IClientCaps_QueryInterface(IClientCaps* This,REFIID riid,void **ppvObject) {
    return This->lpVtbl->QueryInterface(This,riid,ppvObject);
}
static FORCEINLINE ULONG IClientCaps_AddRef(IClientCaps* This) {
    return This->lpVtbl->AddRef(This);
}
static FORCEINLINE ULONG IClientCaps_Release(IClientCaps* This) {
    return This->lpVtbl->Release(This);
}
/*** IDispatch methods ***/
static FORCEINLINE HRESULT IClientCaps_GetTypeInfoCount(IClientCaps* This,UINT *pctinfo) {
    return This->lpVtbl->GetTypeInfoCount(This,pctinfo);
}
static FORCEINLINE HRESULT IClientCaps_GetTypeInfo(IClientCaps* This,UINT iTInfo,LCID lcid,ITypeInfo **ppTInfo) {
    return This->lpVtbl->GetTypeInfo(This,iTInfo,lcid,ppTInfo);
}
static FORCEINLINE HRESULT IClientCaps_GetIDsOfNames(IClientCaps* This,REFIID riid,LPOLESTR *rgszNames,UINT cNames,LCID lcid,DISPID *rgDispId) {
    return This->lpVtbl->GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId);
}
static FORCEINLINE HRESULT IClientCaps_Invoke(IClientCaps* This,DISPID dispIdMember,REFIID riid,LCID lcid,WORD wFlags,DISPPARAMS *pDispParams,VARIANT *pVarResult,EXCEPINFO *pExcepInfo,UINT *puArgErr) {
    return This->lpVtbl->Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr);
}
/*** IClientCaps methods ***/
static FORCEINLINE HRESULT IClientCaps_get_javaEnabled(IClientCaps* This,VARIANT_BOOL *pVal) {
    return This->lpVtbl->get_javaEnabled(This,pVal);
}
static FORCEINLINE HRESULT IClientCaps_get_cookieEnabled(IClientCaps* This,VARIANT_BOOL *pVal) {
    return This->lpVtbl->get_cookieEnabled(This,pVal);
}
static FORCEINLINE HRESULT IClientCaps_get_cpuClass(IClientCaps* This,BSTR *p) {
    return This->lpVtbl->get_cpuClass(This,p);
}
static FORCEINLINE HRESULT IClientCaps_get_systemLanguage(IClientCaps* This,BSTR *p) {
    return This->lpVtbl->get_systemLanguage(This,p);
}
static FORCEINLINE HRESULT IClientCaps_get_userLanguage(IClientCaps* This,BSTR *p) {
    return This->lpVtbl->get_userLanguage(This,p);
}
static FORCEINLINE HRESULT IClientCaps_get_platform(IClientCaps* This,BSTR *p) {
    return This->lpVtbl->get_platform(This,p);
}
static FORCEINLINE HRESULT IClientCaps_get_connectionSpeed(IClientCaps* This,LONG *p) {
    return This->lpVtbl->get_connectionSpeed(This,p);
}
static FORCEINLINE HRESULT IClientCaps_get_onLine(IClientCaps* This,VARIANT_BOOL *p) {
    return This->lpVtbl->get_onLine(This,p);
}
static FORCEINLINE HRESULT IClientCaps_get_colorDepth(IClientCaps* This,LONG *p) {
    return This->lpVtbl->get_colorDepth(This,p);
}
static FORCEINLINE HRESULT IClientCaps_get_bufferDepth(IClientCaps* This,LONG *p) {
    return This->lpVtbl->get_bufferDepth(This,p);
}
static FORCEINLINE HRESULT IClientCaps_get_width(IClientCaps* This,LONG *p) {
    return This->lpVtbl->get_width(This,p);
}
static FORCEINLINE HRESULT IClientCaps_get_height(IClientCaps* This,LONG *p) {
    return This->lpVtbl->get_height(This,p);
}
static FORCEINLINE HRESULT IClientCaps_get_availHeight(IClientCaps* This,LONG *p) {
    return This->lpVtbl->get_availHeight(This,p);
}
static FORCEINLINE HRESULT IClientCaps_get_availWidth(IClientCaps* This,LONG *p) {
    return This->lpVtbl->get_availWidth(This,p);
}
static FORCEINLINE HRESULT IClientCaps_get_connectionType(IClientCaps* This,BSTR *p) {
    return This->lpVtbl->get_connectionType(This,p);
}
static FORCEINLINE HRESULT IClientCaps_isComponentInstalled(IClientCaps* This,BSTR bstrName,BSTR bstrType,BSTR bStrVer,VARIANT_BOOL *p) {
    return This->lpVtbl->isComponentInstalled(This,bstrName,bstrType,bStrVer,p);
}
static FORCEINLINE HRESULT IClientCaps_getComponentVersion(IClientCaps* This,BSTR bstrName,BSTR bstrType,BSTR *pbstrVer) {
    return This->lpVtbl->getComponentVersion(This,bstrName,bstrType,pbstrVer);
}
static FORCEINLINE HRESULT IClientCaps_compareVersions(IClientCaps* This,BSTR bstrVer1,BSTR bstrVer2,LONG *p) {
    return This->lpVtbl->compareVersions(This,bstrVer1,bstrVer2,p);
}
static FORCEINLINE HRESULT IClientCaps_addComponentRequest(IClientCaps* This,BSTR bstrName,BSTR bstrType,BSTR bstrVer) {
    return This->lpVtbl->addComponentRequest(This,bstrName,bstrType,bstrVer);
}
static FORCEINLINE HRESULT IClientCaps_doComponentRequest(IClientCaps* This,VARIANT_BOOL *p) {
    return This->lpVtbl->doComponentRequest(This,p);
}
static FORCEINLINE HRESULT IClientCaps_clearComponentRequest(IClientCaps* This) {
    return This->lpVtbl->clearComponentRequest(This);
}
#endif
#endif

#endif

HRESULT STDMETHODCALLTYPE IClientCaps_get_javaEnabled_Proxy(
    IClientCaps* This,
    VARIANT_BOOL *pVal);
void __RPC_STUB IClientCaps_get_javaEnabled_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE IClientCaps_get_cookieEnabled_Proxy(
    IClientCaps* This,
    VARIANT_BOOL *pVal);
void __RPC_STUB IClientCaps_get_cookieEnabled_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE IClientCaps_get_cpuClass_Proxy(
    IClientCaps* This,
    BSTR *p);
void __RPC_STUB IClientCaps_get_cpuClass_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE IClientCaps_get_systemLanguage_Proxy(
    IClientCaps* This,
    BSTR *p);
void __RPC_STUB IClientCaps_get_systemLanguage_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE IClientCaps_get_userLanguage_Proxy(
    IClientCaps* This,
    BSTR *p);
void __RPC_STUB IClientCaps_get_userLanguage_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE IClientCaps_get_platform_Proxy(
    IClientCaps* This,
    BSTR *p);
void __RPC_STUB IClientCaps_get_platform_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE IClientCaps_get_connectionSpeed_Proxy(
    IClientCaps* This,
    LONG *p);
void __RPC_STUB IClientCaps_get_connectionSpeed_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE IClientCaps_get_onLine_Proxy(
    IClientCaps* This,
    VARIANT_BOOL *p);
void __RPC_STUB IClientCaps_get_onLine_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE IClientCaps_get_colorDepth_Proxy(
    IClientCaps* This,
    LONG *p);
void __RPC_STUB IClientCaps_get_colorDepth_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE IClientCaps_get_bufferDepth_Proxy(
    IClientCaps* This,
    LONG *p);
void __RPC_STUB IClientCaps_get_bufferDepth_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE IClientCaps_get_width_Proxy(
    IClientCaps* This,
    LONG *p);
void __RPC_STUB IClientCaps_get_width_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE IClientCaps_get_height_Proxy(
    IClientCaps* This,
    LONG *p);
void __RPC_STUB IClientCaps_get_height_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE IClientCaps_get_availHeight_Proxy(
    IClientCaps* This,
    LONG *p);
void __RPC_STUB IClientCaps_get_availHeight_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE IClientCaps_get_availWidth_Proxy(
    IClientCaps* This,
    LONG *p);
void __RPC_STUB IClientCaps_get_availWidth_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE IClientCaps_get_connectionType_Proxy(
    IClientCaps* This,
    BSTR *p);
void __RPC_STUB IClientCaps_get_connectionType_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE IClientCaps_isComponentInstalled_Proxy(
    IClientCaps* This,
    BSTR bstrName,
    BSTR bstrType,
    BSTR bStrVer,
    VARIANT_BOOL *p);
void __RPC_STUB IClientCaps_isComponentInstalled_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE IClientCaps_getComponentVersion_Proxy(
    IClientCaps* This,
    BSTR bstrName,
    BSTR bstrType,
    BSTR *pbstrVer);
void __RPC_STUB IClientCaps_getComponentVersion_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE IClientCaps_compareVersions_Proxy(
    IClientCaps* This,
    BSTR bstrVer1,
    BSTR bstrVer2,
    LONG *p);
void __RPC_STUB IClientCaps_compareVersions_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE IClientCaps_addComponentRequest_Proxy(
    IClientCaps* This,
    BSTR bstrName,
    BSTR bstrType,
    BSTR bstrVer);
void __RPC_STUB IClientCaps_addComponentRequest_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE IClientCaps_doComponentRequest_Proxy(
    IClientCaps* This,
    VARIANT_BOOL *p);
void __RPC_STUB IClientCaps_doComponentRequest_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE IClientCaps_clearComponentRequest_Proxy(
    IClientCaps* This);
void __RPC_STUB IClientCaps_clearComponentRequest_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);

#endif  /* __IClientCaps_INTERFACE_DEFINED__ */


DEFINE_GUID(LIBID_IEXTagLib, 0x7e8bc440, 0xaeff, 0x11d1, 0x89,0xc2, 0x00,0xc0,0x4f,0xb6,0xbf,0xc4);

/*****************************************************************************
 * ClientCaps coclass
 */

DEFINE_GUID(CLSID_ClientCaps, 0x7e8bc44e, 0xaeff, 0x11d1, 0x89,0xc2, 0x00,0xc0,0x4f,0xb6,0xbf,0xc4);

#ifdef __cplusplus
class DECLSPEC_UUID("7e8bc44e-aeff-11d1-89c2-00c04fb6bfc4") ClientCaps;
#ifdef __CRT_UUID_DECL
__CRT_UUID_DECL(ClientCaps, 0x7e8bc44e, 0xaeff, 0x11d1, 0x89,0xc2, 0x00,0xc0,0x4f,0xb6,0xbf,0xc4)
#endif
#endif

/* Begin additional prototypes for all interfaces */

ULONG           __RPC_USER BSTR_UserSize     (ULONG *, ULONG, BSTR *);
unsigned char * __RPC_USER BSTR_UserMarshal  (ULONG *, unsigned char *, BSTR *);
unsigned char * __RPC_USER BSTR_UserUnmarshal(ULONG *, unsigned char *, BSTR *);
void            __RPC_USER BSTR_UserFree     (ULONG *, BSTR *);

/* End additional prototypes */

#ifdef __cplusplus
}
#endif

#endif /* __iextag_h__ */
