/*** Autogenerated by WIDL 1.9.0 from sensevts.idl - Do not edit ***/

#ifndef __REQUIRED_RPCNDR_H_VERSION__
#define __REQUIRED_RPCNDR_H_VERSION__ 475
#endif

#include <rpc.h>
#include <rpcndr.h>

#ifndef COM_NO_WINDOWS_H
#include <windows.h>
#include <ole2.h>
#endif

#ifndef __sensevts_h__
#define __sensevts_h__

/* Forward declarations */

#ifndef __ISensNetwork_FWD_DEFINED__
#define __ISensNetwork_FWD_DEFINED__
typedef interface ISensNetwork ISensNetwork;
#ifdef __cplusplus
interface ISensNetwork;
#endif /* __cplusplus */
#endif

#ifndef __ISensOnNow_FWD_DEFINED__
#define __ISensOnNow_FWD_DEFINED__
typedef interface ISensOnNow ISensOnNow;
#ifdef __cplusplus
interface ISensOnNow;
#endif /* __cplusplus */
#endif

#ifndef __ISensLogon_FWD_DEFINED__
#define __ISensLogon_FWD_DEFINED__
typedef interface ISensLogon ISensLogon;
#ifdef __cplusplus
interface ISensLogon;
#endif /* __cplusplus */
#endif

#ifndef __ISensLogon2_FWD_DEFINED__
#define __ISensLogon2_FWD_DEFINED__
typedef interface ISensLogon2 ISensLogon2;
#ifdef __cplusplus
interface ISensLogon2;
#endif /* __cplusplus */
#endif

/* Headers for imported files */

#include <wtypes.h>
#include <oaidl.h>

#ifdef __cplusplus
extern "C" {
#endif


DEFINE_GUID(LIBID_SensEvents, 0xd597deed, 0x5b9f, 0x11d1, 0x8d,0xd2, 0x00,0xaa,0x00,0x4a,0xbd,0x5e);

typedef struct SENS_QOCINFO {
    DWORD dwSize;
    DWORD dwFlags;
    DWORD dwOutSpeed;
    DWORD dwInSpeed;
} SENS_QOCINFO;
typedef struct SENS_QOCINFO *LPSENS_QOCINFO;
/*****************************************************************************
 * ISensNetwork interface
 */
#ifndef __ISensNetwork_INTERFACE_DEFINED__
#define __ISensNetwork_INTERFACE_DEFINED__

DEFINE_GUID(IID_ISensNetwork, 0xd597bab1, 0x5b9f, 0x11d1, 0x8d,0xd2, 0x00,0xaa,0x00,0x4a,0xbd,0x5e);
#if defined(__cplusplus) && !defined(CINTERFACE)
MIDL_INTERFACE("d597bab1-5b9f-11d1-8dd2-00aa004abd5e")
ISensNetwork : public IDispatch
{
    virtual HRESULT STDMETHODCALLTYPE ConnectionMade(
        BSTR bstrConnection,
        ULONG ulType,
        LPSENS_QOCINFO lpQOCInfo) = 0;

    virtual HRESULT STDMETHODCALLTYPE ConnectionMadeNoQOCInfo(
        BSTR bstrConnection,
        ULONG ulType) = 0;

    virtual HRESULT STDMETHODCALLTYPE ConnectionLost(
        BSTR bstrConnection,
        ULONG ulType) = 0;

    virtual HRESULT STDMETHODCALLTYPE DestinationReachable(
        BSTR bstrDestination,
        BSTR bstrConnection,
        ULONG ulType,
        LPSENS_QOCINFO lpQOCInfo) = 0;

    virtual HRESULT STDMETHODCALLTYPE DestinationReachableNoQOCInfo(
        BSTR bstrDestination,
        BSTR bstrConnection,
        ULONG ulType) = 0;

};
#ifdef __CRT_UUID_DECL
__CRT_UUID_DECL(ISensNetwork, 0xd597bab1, 0x5b9f, 0x11d1, 0x8d,0xd2, 0x00,0xaa,0x00,0x4a,0xbd,0x5e)
#endif
#else
typedef struct ISensNetworkVtbl {
    BEGIN_INTERFACE

    /*** IUnknown methods ***/
    HRESULT (STDMETHODCALLTYPE *QueryInterface)(
        ISensNetwork *This,
        REFIID riid,
        void **ppvObject);

    ULONG (STDMETHODCALLTYPE *AddRef)(
        ISensNetwork *This);

    ULONG (STDMETHODCALLTYPE *Release)(
        ISensNetwork *This);

    /*** IDispatch methods ***/
    HRESULT (STDMETHODCALLTYPE *GetTypeInfoCount)(
        ISensNetwork *This,
        UINT *pctinfo);

    HRESULT (STDMETHODCALLTYPE *GetTypeInfo)(
        ISensNetwork *This,
        UINT iTInfo,
        LCID lcid,
        ITypeInfo **ppTInfo);

    HRESULT (STDMETHODCALLTYPE *GetIDsOfNames)(
        ISensNetwork *This,
        REFIID riid,
        LPOLESTR *rgszNames,
        UINT cNames,
        LCID lcid,
        DISPID *rgDispId);

    HRESULT (STDMETHODCALLTYPE *Invoke)(
        ISensNetwork *This,
        DISPID dispIdMember,
        REFIID riid,
        LCID lcid,
        WORD wFlags,
        DISPPARAMS *pDispParams,
        VARIANT *pVarResult,
        EXCEPINFO *pExcepInfo,
        UINT *puArgErr);

    /*** ISensNetwork methods ***/
    HRESULT (STDMETHODCALLTYPE *ConnectionMade)(
        ISensNetwork *This,
        BSTR bstrConnection,
        ULONG ulType,
        LPSENS_QOCINFO lpQOCInfo);

    HRESULT (STDMETHODCALLTYPE *ConnectionMadeNoQOCInfo)(
        ISensNetwork *This,
        BSTR bstrConnection,
        ULONG ulType);

    HRESULT (STDMETHODCALLTYPE *ConnectionLost)(
        ISensNetwork *This,
        BSTR bstrConnection,
        ULONG ulType);

    HRESULT (STDMETHODCALLTYPE *DestinationReachable)(
        ISensNetwork *This,
        BSTR bstrDestination,
        BSTR bstrConnection,
        ULONG ulType,
        LPSENS_QOCINFO lpQOCInfo);

    HRESULT (STDMETHODCALLTYPE *DestinationReachableNoQOCInfo)(
        ISensNetwork *This,
        BSTR bstrDestination,
        BSTR bstrConnection,
        ULONG ulType);

    END_INTERFACE
} ISensNetworkVtbl;

interface ISensNetwork {
    CONST_VTBL ISensNetworkVtbl* lpVtbl;
};

#ifdef COBJMACROS
#ifndef WIDL_C_INLINE_WRAPPERS
/*** IUnknown methods ***/
#define ISensNetwork_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define ISensNetwork_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ISensNetwork_Release(This) (This)->lpVtbl->Release(This)
/*** IDispatch methods ***/
#define ISensNetwork_GetTypeInfoCount(This,pctinfo) (This)->lpVtbl->GetTypeInfoCount(This,pctinfo)
#define ISensNetwork_GetTypeInfo(This,iTInfo,lcid,ppTInfo) (This)->lpVtbl->GetTypeInfo(This,iTInfo,lcid,ppTInfo)
#define ISensNetwork_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) (This)->lpVtbl->GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)
#define ISensNetwork_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) (This)->lpVtbl->Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)
/*** ISensNetwork methods ***/
#define ISensNetwork_ConnectionMade(This,bstrConnection,ulType,lpQOCInfo) (This)->lpVtbl->ConnectionMade(This,bstrConnection,ulType,lpQOCInfo)
#define ISensNetwork_ConnectionMadeNoQOCInfo(This,bstrConnection,ulType) (This)->lpVtbl->ConnectionMadeNoQOCInfo(This,bstrConnection,ulType)
#define ISensNetwork_ConnectionLost(This,bstrConnection,ulType) (This)->lpVtbl->ConnectionLost(This,bstrConnection,ulType)
#define ISensNetwork_DestinationReachable(This,bstrDestination,bstrConnection,ulType,lpQOCInfo) (This)->lpVtbl->DestinationReachable(This,bstrDestination,bstrConnection,ulType,lpQOCInfo)
#define ISensNetwork_DestinationReachableNoQOCInfo(This,bstrDestination,bstrConnection,ulType) (This)->lpVtbl->DestinationReachableNoQOCInfo(This,bstrDestination,bstrConnection,ulType)
#else
/*** IUnknown methods ***/
static FORCEINLINE HRESULT ISensNetwork_QueryInterface(ISensNetwork* This,REFIID riid,void **ppvObject) {
    return This->lpVtbl->QueryInterface(This,riid,ppvObject);
}
static FORCEINLINE ULONG ISensNetwork_AddRef(ISensNetwork* This) {
    return This->lpVtbl->AddRef(This);
}
static FORCEINLINE ULONG ISensNetwork_Release(ISensNetwork* This) {
    return This->lpVtbl->Release(This);
}
/*** IDispatch methods ***/
static FORCEINLINE HRESULT ISensNetwork_GetTypeInfoCount(ISensNetwork* This,UINT *pctinfo) {
    return This->lpVtbl->GetTypeInfoCount(This,pctinfo);
}
static FORCEINLINE HRESULT ISensNetwork_GetTypeInfo(ISensNetwork* This,UINT iTInfo,LCID lcid,ITypeInfo **ppTInfo) {
    return This->lpVtbl->GetTypeInfo(This,iTInfo,lcid,ppTInfo);
}
static FORCEINLINE HRESULT ISensNetwork_GetIDsOfNames(ISensNetwork* This,REFIID riid,LPOLESTR *rgszNames,UINT cNames,LCID lcid,DISPID *rgDispId) {
    return This->lpVtbl->GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId);
}
static FORCEINLINE HRESULT ISensNetwork_Invoke(ISensNetwork* This,DISPID dispIdMember,REFIID riid,LCID lcid,WORD wFlags,DISPPARAMS *pDispParams,VARIANT *pVarResult,EXCEPINFO *pExcepInfo,UINT *puArgErr) {
    return This->lpVtbl->Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr);
}
/*** ISensNetwork methods ***/
static FORCEINLINE HRESULT ISensNetwork_ConnectionMade(ISensNetwork* This,BSTR bstrConnection,ULONG ulType,LPSENS_QOCINFO lpQOCInfo) {
    return This->lpVtbl->ConnectionMade(This,bstrConnection,ulType,lpQOCInfo);
}
static FORCEINLINE HRESULT ISensNetwork_ConnectionMadeNoQOCInfo(ISensNetwork* This,BSTR bstrConnection,ULONG ulType) {
    return This->lpVtbl->ConnectionMadeNoQOCInfo(This,bstrConnection,ulType);
}
static FORCEINLINE HRESULT ISensNetwork_ConnectionLost(ISensNetwork* This,BSTR bstrConnection,ULONG ulType) {
    return This->lpVtbl->ConnectionLost(This,bstrConnection,ulType);
}
static FORCEINLINE HRESULT ISensNetwork_DestinationReachable(ISensNetwork* This,BSTR bstrDestination,BSTR bstrConnection,ULONG ulType,LPSENS_QOCINFO lpQOCInfo) {
    return This->lpVtbl->DestinationReachable(This,bstrDestination,bstrConnection,ulType,lpQOCInfo);
}
static FORCEINLINE HRESULT ISensNetwork_DestinationReachableNoQOCInfo(ISensNetwork* This,BSTR bstrDestination,BSTR bstrConnection,ULONG ulType) {
    return This->lpVtbl->DestinationReachableNoQOCInfo(This,bstrDestination,bstrConnection,ulType);
}
#endif
#endif

#endif

HRESULT STDMETHODCALLTYPE ISensNetwork_ConnectionMade_Proxy(
    ISensNetwork* This,
    BSTR bstrConnection,
    ULONG ulType,
    LPSENS_QOCINFO lpQOCInfo);
void __RPC_STUB ISensNetwork_ConnectionMade_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE ISensNetwork_ConnectionMadeNoQOCInfo_Proxy(
    ISensNetwork* This,
    BSTR bstrConnection,
    ULONG ulType);
void __RPC_STUB ISensNetwork_ConnectionMadeNoQOCInfo_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE ISensNetwork_ConnectionLost_Proxy(
    ISensNetwork* This,
    BSTR bstrConnection,
    ULONG ulType);
void __RPC_STUB ISensNetwork_ConnectionLost_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE ISensNetwork_DestinationReachable_Proxy(
    ISensNetwork* This,
    BSTR bstrDestination,
    BSTR bstrConnection,
    ULONG ulType,
    LPSENS_QOCINFO lpQOCInfo);
void __RPC_STUB ISensNetwork_DestinationReachable_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE ISensNetwork_DestinationReachableNoQOCInfo_Proxy(
    ISensNetwork* This,
    BSTR bstrDestination,
    BSTR bstrConnection,
    ULONG ulType);
void __RPC_STUB ISensNetwork_DestinationReachableNoQOCInfo_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);

#endif  /* __ISensNetwork_INTERFACE_DEFINED__ */

/*****************************************************************************
 * ISensOnNow interface
 */
#ifndef __ISensOnNow_INTERFACE_DEFINED__
#define __ISensOnNow_INTERFACE_DEFINED__

DEFINE_GUID(IID_ISensOnNow, 0xd597bab2, 0x5b9f, 0x11d1, 0x8d,0xd2, 0x00,0xaa,0x00,0x4a,0xbd,0x5e);
#if defined(__cplusplus) && !defined(CINTERFACE)
MIDL_INTERFACE("d597bab2-5b9f-11d1-8dd2-00aa004abd5e")
ISensOnNow : public IDispatch
{
    virtual HRESULT STDMETHODCALLTYPE OnAcPower(
        ) = 0;

    virtual HRESULT STDMETHODCALLTYPE OnBatteryPower(
        DWORD dwBatteryLifePercent) = 0;

    virtual HRESULT STDMETHODCALLTYPE BatteryLow(
        DWORD dwBatteryLifePercent) = 0;

};
#ifdef __CRT_UUID_DECL
__CRT_UUID_DECL(ISensOnNow, 0xd597bab2, 0x5b9f, 0x11d1, 0x8d,0xd2, 0x00,0xaa,0x00,0x4a,0xbd,0x5e)
#endif
#else
typedef struct ISensOnNowVtbl {
    BEGIN_INTERFACE

    /*** IUnknown methods ***/
    HRESULT (STDMETHODCALLTYPE *QueryInterface)(
        ISensOnNow *This,
        REFIID riid,
        void **ppvObject);

    ULONG (STDMETHODCALLTYPE *AddRef)(
        ISensOnNow *This);

    ULONG (STDMETHODCALLTYPE *Release)(
        ISensOnNow *This);

    /*** IDispatch methods ***/
    HRESULT (STDMETHODCALLTYPE *GetTypeInfoCount)(
        ISensOnNow *This,
        UINT *pctinfo);

    HRESULT (STDMETHODCALLTYPE *GetTypeInfo)(
        ISensOnNow *This,
        UINT iTInfo,
        LCID lcid,
        ITypeInfo **ppTInfo);

    HRESULT (STDMETHODCALLTYPE *GetIDsOfNames)(
        ISensOnNow *This,
        REFIID riid,
        LPOLESTR *rgszNames,
        UINT cNames,
        LCID lcid,
        DISPID *rgDispId);

    HRESULT (STDMETHODCALLTYPE *Invoke)(
        ISensOnNow *This,
        DISPID dispIdMember,
        REFIID riid,
        LCID lcid,
        WORD wFlags,
        DISPPARAMS *pDispParams,
        VARIANT *pVarResult,
        EXCEPINFO *pExcepInfo,
        UINT *puArgErr);

    /*** ISensOnNow methods ***/
    HRESULT (STDMETHODCALLTYPE *OnAcPower)(
        ISensOnNow *This);

    HRESULT (STDMETHODCALLTYPE *OnBatteryPower)(
        ISensOnNow *This,
        DWORD dwBatteryLifePercent);

    HRESULT (STDMETHODCALLTYPE *BatteryLow)(
        ISensOnNow *This,
        DWORD dwBatteryLifePercent);

    END_INTERFACE
} ISensOnNowVtbl;

interface ISensOnNow {
    CONST_VTBL ISensOnNowVtbl* lpVtbl;
};

#ifdef COBJMACROS
#ifndef WIDL_C_INLINE_WRAPPERS
/*** IUnknown methods ***/
#define ISensOnNow_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define ISensOnNow_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ISensOnNow_Release(This) (This)->lpVtbl->Release(This)
/*** IDispatch methods ***/
#define ISensOnNow_GetTypeInfoCount(This,pctinfo) (This)->lpVtbl->GetTypeInfoCount(This,pctinfo)
#define ISensOnNow_GetTypeInfo(This,iTInfo,lcid,ppTInfo) (This)->lpVtbl->GetTypeInfo(This,iTInfo,lcid,ppTInfo)
#define ISensOnNow_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) (This)->lpVtbl->GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)
#define ISensOnNow_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) (This)->lpVtbl->Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)
/*** ISensOnNow methods ***/
#define ISensOnNow_OnAcPower(This) (This)->lpVtbl->OnAcPower(This)
#define ISensOnNow_OnBatteryPower(This,dwBatteryLifePercent) (This)->lpVtbl->OnBatteryPower(This,dwBatteryLifePercent)
#define ISensOnNow_BatteryLow(This,dwBatteryLifePercent) (This)->lpVtbl->BatteryLow(This,dwBatteryLifePercent)
#else
/*** IUnknown methods ***/
static FORCEINLINE HRESULT ISensOnNow_QueryInterface(ISensOnNow* This,REFIID riid,void **ppvObject) {
    return This->lpVtbl->QueryInterface(This,riid,ppvObject);
}
static FORCEINLINE ULONG ISensOnNow_AddRef(ISensOnNow* This) {
    return This->lpVtbl->AddRef(This);
}
static FORCEINLINE ULONG ISensOnNow_Release(ISensOnNow* This) {
    return This->lpVtbl->Release(This);
}
/*** IDispatch methods ***/
static FORCEINLINE HRESULT ISensOnNow_GetTypeInfoCount(ISensOnNow* This,UINT *pctinfo) {
    return This->lpVtbl->GetTypeInfoCount(This,pctinfo);
}
static FORCEINLINE HRESULT ISensOnNow_GetTypeInfo(ISensOnNow* This,UINT iTInfo,LCID lcid,ITypeInfo **ppTInfo) {
    return This->lpVtbl->GetTypeInfo(This,iTInfo,lcid,ppTInfo);
}
static FORCEINLINE HRESULT ISensOnNow_GetIDsOfNames(ISensOnNow* This,REFIID riid,LPOLESTR *rgszNames,UINT cNames,LCID lcid,DISPID *rgDispId) {
    return This->lpVtbl->GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId);
}
static FORCEINLINE HRESULT ISensOnNow_Invoke(ISensOnNow* This,DISPID dispIdMember,REFIID riid,LCID lcid,WORD wFlags,DISPPARAMS *pDispParams,VARIANT *pVarResult,EXCEPINFO *pExcepInfo,UINT *puArgErr) {
    return This->lpVtbl->Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr);
}
/*** ISensOnNow methods ***/
static FORCEINLINE HRESULT ISensOnNow_OnAcPower(ISensOnNow* This) {
    return This->lpVtbl->OnAcPower(This);
}
static FORCEINLINE HRESULT ISensOnNow_OnBatteryPower(ISensOnNow* This,DWORD dwBatteryLifePercent) {
    return This->lpVtbl->OnBatteryPower(This,dwBatteryLifePercent);
}
static FORCEINLINE HRESULT ISensOnNow_BatteryLow(ISensOnNow* This,DWORD dwBatteryLifePercent) {
    return This->lpVtbl->BatteryLow(This,dwBatteryLifePercent);
}
#endif
#endif

#endif

HRESULT STDMETHODCALLTYPE ISensOnNow_OnAcPower_Proxy(
    ISensOnNow* This);
void __RPC_STUB ISensOnNow_OnAcPower_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE ISensOnNow_OnBatteryPower_Proxy(
    ISensOnNow* This,
    DWORD dwBatteryLifePercent);
void __RPC_STUB ISensOnNow_OnBatteryPower_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE ISensOnNow_BatteryLow_Proxy(
    ISensOnNow* This,
    DWORD dwBatteryLifePercent);
void __RPC_STUB ISensOnNow_BatteryLow_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);

#endif  /* __ISensOnNow_INTERFACE_DEFINED__ */

/*****************************************************************************
 * ISensLogon interface
 */
#ifndef __ISensLogon_INTERFACE_DEFINED__
#define __ISensLogon_INTERFACE_DEFINED__

DEFINE_GUID(IID_ISensLogon, 0xd597bab3, 0x5b9f, 0x11d1, 0x8d,0xd2, 0x00,0xaa,0x00,0x4a,0xbd,0x5e);
#if defined(__cplusplus) && !defined(CINTERFACE)
MIDL_INTERFACE("d597bab3-5b9f-11d1-8dd2-00aa004abd5e")
ISensLogon : public IDispatch
{
    virtual HRESULT STDMETHODCALLTYPE Logon(
        BSTR bstrUserName) = 0;

    virtual HRESULT STDMETHODCALLTYPE Logoff(
        BSTR bstrUserName) = 0;

    virtual HRESULT STDMETHODCALLTYPE StartShell(
        BSTR bstrUserName) = 0;

    virtual HRESULT STDMETHODCALLTYPE DisplayLock(
        BSTR bstrUserName) = 0;

    virtual HRESULT STDMETHODCALLTYPE DisplayUnlock(
        BSTR bstrUserName) = 0;

    virtual HRESULT STDMETHODCALLTYPE StartScreenSaver(
        BSTR bstrUserName) = 0;

    virtual HRESULT STDMETHODCALLTYPE StopScreenSaver(
        BSTR bstrUserName) = 0;

};
#ifdef __CRT_UUID_DECL
__CRT_UUID_DECL(ISensLogon, 0xd597bab3, 0x5b9f, 0x11d1, 0x8d,0xd2, 0x00,0xaa,0x00,0x4a,0xbd,0x5e)
#endif
#else
typedef struct ISensLogonVtbl {
    BEGIN_INTERFACE

    /*** IUnknown methods ***/
    HRESULT (STDMETHODCALLTYPE *QueryInterface)(
        ISensLogon *This,
        REFIID riid,
        void **ppvObject);

    ULONG (STDMETHODCALLTYPE *AddRef)(
        ISensLogon *This);

    ULONG (STDMETHODCALLTYPE *Release)(
        ISensLogon *This);

    /*** IDispatch methods ***/
    HRESULT (STDMETHODCALLTYPE *GetTypeInfoCount)(
        ISensLogon *This,
        UINT *pctinfo);

    HRESULT (STDMETHODCALLTYPE *GetTypeInfo)(
        ISensLogon *This,
        UINT iTInfo,
        LCID lcid,
        ITypeInfo **ppTInfo);

    HRESULT (STDMETHODCALLTYPE *GetIDsOfNames)(
        ISensLogon *This,
        REFIID riid,
        LPOLESTR *rgszNames,
        UINT cNames,
        LCID lcid,
        DISPID *rgDispId);

    HRESULT (STDMETHODCALLTYPE *Invoke)(
        ISensLogon *This,
        DISPID dispIdMember,
        REFIID riid,
        LCID lcid,
        WORD wFlags,
        DISPPARAMS *pDispParams,
        VARIANT *pVarResult,
        EXCEPINFO *pExcepInfo,
        UINT *puArgErr);

    /*** ISensLogon methods ***/
    HRESULT (STDMETHODCALLTYPE *Logon)(
        ISensLogon *This,
        BSTR bstrUserName);

    HRESULT (STDMETHODCALLTYPE *Logoff)(
        ISensLogon *This,
        BSTR bstrUserName);

    HRESULT (STDMETHODCALLTYPE *StartShell)(
        ISensLogon *This,
        BSTR bstrUserName);

    HRESULT (STDMETHODCALLTYPE *DisplayLock)(
        ISensLogon *This,
        BSTR bstrUserName);

    HRESULT (STDMETHODCALLTYPE *DisplayUnlock)(
        ISensLogon *This,
        BSTR bstrUserName);

    HRESULT (STDMETHODCALLTYPE *StartScreenSaver)(
        ISensLogon *This,
        BSTR bstrUserName);

    HRESULT (STDMETHODCALLTYPE *StopScreenSaver)(
        ISensLogon *This,
        BSTR bstrUserName);

    END_INTERFACE
} ISensLogonVtbl;

interface ISensLogon {
    CONST_VTBL ISensLogonVtbl* lpVtbl;
};

#ifdef COBJMACROS
#ifndef WIDL_C_INLINE_WRAPPERS
/*** IUnknown methods ***/
#define ISensLogon_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define ISensLogon_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ISensLogon_Release(This) (This)->lpVtbl->Release(This)
/*** IDispatch methods ***/
#define ISensLogon_GetTypeInfoCount(This,pctinfo) (This)->lpVtbl->GetTypeInfoCount(This,pctinfo)
#define ISensLogon_GetTypeInfo(This,iTInfo,lcid,ppTInfo) (This)->lpVtbl->GetTypeInfo(This,iTInfo,lcid,ppTInfo)
#define ISensLogon_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) (This)->lpVtbl->GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)
#define ISensLogon_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) (This)->lpVtbl->Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)
/*** ISensLogon methods ***/
#define ISensLogon_Logon(This,bstrUserName) (This)->lpVtbl->Logon(This,bstrUserName)
#define ISensLogon_Logoff(This,bstrUserName) (This)->lpVtbl->Logoff(This,bstrUserName)
#define ISensLogon_StartShell(This,bstrUserName) (This)->lpVtbl->StartShell(This,bstrUserName)
#define ISensLogon_DisplayLock(This,bstrUserName) (This)->lpVtbl->DisplayLock(This,bstrUserName)
#define ISensLogon_DisplayUnlock(This,bstrUserName) (This)->lpVtbl->DisplayUnlock(This,bstrUserName)
#define ISensLogon_StartScreenSaver(This,bstrUserName) (This)->lpVtbl->StartScreenSaver(This,bstrUserName)
#define ISensLogon_StopScreenSaver(This,bstrUserName) (This)->lpVtbl->StopScreenSaver(This,bstrUserName)
#else
/*** IUnknown methods ***/
static FORCEINLINE HRESULT ISensLogon_QueryInterface(ISensLogon* This,REFIID riid,void **ppvObject) {
    return This->lpVtbl->QueryInterface(This,riid,ppvObject);
}
static FORCEINLINE ULONG ISensLogon_AddRef(ISensLogon* This) {
    return This->lpVtbl->AddRef(This);
}
static FORCEINLINE ULONG ISensLogon_Release(ISensLogon* This) {
    return This->lpVtbl->Release(This);
}
/*** IDispatch methods ***/
static FORCEINLINE HRESULT ISensLogon_GetTypeInfoCount(ISensLogon* This,UINT *pctinfo) {
    return This->lpVtbl->GetTypeInfoCount(This,pctinfo);
}
static FORCEINLINE HRESULT ISensLogon_GetTypeInfo(ISensLogon* This,UINT iTInfo,LCID lcid,ITypeInfo **ppTInfo) {
    return This->lpVtbl->GetTypeInfo(This,iTInfo,lcid,ppTInfo);
}
static FORCEINLINE HRESULT ISensLogon_GetIDsOfNames(ISensLogon* This,REFIID riid,LPOLESTR *rgszNames,UINT cNames,LCID lcid,DISPID *rgDispId) {
    return This->lpVtbl->GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId);
}
static FORCEINLINE HRESULT ISensLogon_Invoke(ISensLogon* This,DISPID dispIdMember,REFIID riid,LCID lcid,WORD wFlags,DISPPARAMS *pDispParams,VARIANT *pVarResult,EXCEPINFO *pExcepInfo,UINT *puArgErr) {
    return This->lpVtbl->Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr);
}
/*** ISensLogon methods ***/
static FORCEINLINE HRESULT ISensLogon_Logon(ISensLogon* This,BSTR bstrUserName) {
    return This->lpVtbl->Logon(This,bstrUserName);
}
static FORCEINLINE HRESULT ISensLogon_Logoff(ISensLogon* This,BSTR bstrUserName) {
    return This->lpVtbl->Logoff(This,bstrUserName);
}
static FORCEINLINE HRESULT ISensLogon_StartShell(ISensLogon* This,BSTR bstrUserName) {
    return This->lpVtbl->StartShell(This,bstrUserName);
}
static FORCEINLINE HRESULT ISensLogon_DisplayLock(ISensLogon* This,BSTR bstrUserName) {
    return This->lpVtbl->DisplayLock(This,bstrUserName);
}
static FORCEINLINE HRESULT ISensLogon_DisplayUnlock(ISensLogon* This,BSTR bstrUserName) {
    return This->lpVtbl->DisplayUnlock(This,bstrUserName);
}
static FORCEINLINE HRESULT ISensLogon_StartScreenSaver(ISensLogon* This,BSTR bstrUserName) {
    return This->lpVtbl->StartScreenSaver(This,bstrUserName);
}
static FORCEINLINE HRESULT ISensLogon_StopScreenSaver(ISensLogon* This,BSTR bstrUserName) {
    return This->lpVtbl->StopScreenSaver(This,bstrUserName);
}
#endif
#endif

#endif

HRESULT STDMETHODCALLTYPE ISensLogon_Logon_Proxy(
    ISensLogon* This,
    BSTR bstrUserName);
void __RPC_STUB ISensLogon_Logon_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE ISensLogon_Logoff_Proxy(
    ISensLogon* This,
    BSTR bstrUserName);
void __RPC_STUB ISensLogon_Logoff_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE ISensLogon_StartShell_Proxy(
    ISensLogon* This,
    BSTR bstrUserName);
void __RPC_STUB ISensLogon_StartShell_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE ISensLogon_DisplayLock_Proxy(
    ISensLogon* This,
    BSTR bstrUserName);
void __RPC_STUB ISensLogon_DisplayLock_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE ISensLogon_DisplayUnlock_Proxy(
    ISensLogon* This,
    BSTR bstrUserName);
void __RPC_STUB ISensLogon_DisplayUnlock_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE ISensLogon_StartScreenSaver_Proxy(
    ISensLogon* This,
    BSTR bstrUserName);
void __RPC_STUB ISensLogon_StartScreenSaver_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE ISensLogon_StopScreenSaver_Proxy(
    ISensLogon* This,
    BSTR bstrUserName);
void __RPC_STUB ISensLogon_StopScreenSaver_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);

#endif  /* __ISensLogon_INTERFACE_DEFINED__ */

/*****************************************************************************
 * ISensLogon2 interface
 */
#ifndef __ISensLogon2_INTERFACE_DEFINED__
#define __ISensLogon2_INTERFACE_DEFINED__

DEFINE_GUID(IID_ISensLogon2, 0xd597bab4, 0x5b9f, 0x11d1, 0x8d,0xd2, 0x00,0xaa,0x00,0x4a,0xbd,0x5e);
#if defined(__cplusplus) && !defined(CINTERFACE)
MIDL_INTERFACE("d597bab4-5b9f-11d1-8dd2-00aa004abd5e")
ISensLogon2 : public IDispatch
{
    virtual HRESULT STDMETHODCALLTYPE Logon(
        BSTR bstrUserName,
        DWORD dwSessionId) = 0;

    virtual HRESULT STDMETHODCALLTYPE Logoff(
        BSTR bstrUserName,
        DWORD dwSessionId) = 0;

    virtual HRESULT STDMETHODCALLTYPE SessionDisconnect(
        BSTR bstrUserName,
        DWORD dwSessionId) = 0;

    virtual HRESULT STDMETHODCALLTYPE SessionReconnect(
        BSTR bstrUserName,
        DWORD dwSessionId) = 0;

    virtual HRESULT STDMETHODCALLTYPE PostShell(
        BSTR bstrUserName,
        DWORD dwSessionId) = 0;

};
#ifdef __CRT_UUID_DECL
__CRT_UUID_DECL(ISensLogon2, 0xd597bab4, 0x5b9f, 0x11d1, 0x8d,0xd2, 0x00,0xaa,0x00,0x4a,0xbd,0x5e)
#endif
#else
typedef struct ISensLogon2Vtbl {
    BEGIN_INTERFACE

    /*** IUnknown methods ***/
    HRESULT (STDMETHODCALLTYPE *QueryInterface)(
        ISensLogon2 *This,
        REFIID riid,
        void **ppvObject);

    ULONG (STDMETHODCALLTYPE *AddRef)(
        ISensLogon2 *This);

    ULONG (STDMETHODCALLTYPE *Release)(
        ISensLogon2 *This);

    /*** IDispatch methods ***/
    HRESULT (STDMETHODCALLTYPE *GetTypeInfoCount)(
        ISensLogon2 *This,
        UINT *pctinfo);

    HRESULT (STDMETHODCALLTYPE *GetTypeInfo)(
        ISensLogon2 *This,
        UINT iTInfo,
        LCID lcid,
        ITypeInfo **ppTInfo);

    HRESULT (STDMETHODCALLTYPE *GetIDsOfNames)(
        ISensLogon2 *This,
        REFIID riid,
        LPOLESTR *rgszNames,
        UINT cNames,
        LCID lcid,
        DISPID *rgDispId);

    HRESULT (STDMETHODCALLTYPE *Invoke)(
        ISensLogon2 *This,
        DISPID dispIdMember,
        REFIID riid,
        LCID lcid,
        WORD wFlags,
        DISPPARAMS *pDispParams,
        VARIANT *pVarResult,
        EXCEPINFO *pExcepInfo,
        UINT *puArgErr);

    /*** ISensLogon2 methods ***/
    HRESULT (STDMETHODCALLTYPE *Logon)(
        ISensLogon2 *This,
        BSTR bstrUserName,
        DWORD dwSessionId);

    HRESULT (STDMETHODCALLTYPE *Logoff)(
        ISensLogon2 *This,
        BSTR bstrUserName,
        DWORD dwSessionId);

    HRESULT (STDMETHODCALLTYPE *SessionDisconnect)(
        ISensLogon2 *This,
        BSTR bstrUserName,
        DWORD dwSessionId);

    HRESULT (STDMETHODCALLTYPE *SessionReconnect)(
        ISensLogon2 *This,
        BSTR bstrUserName,
        DWORD dwSessionId);

    HRESULT (STDMETHODCALLTYPE *PostShell)(
        ISensLogon2 *This,
        BSTR bstrUserName,
        DWORD dwSessionId);

    END_INTERFACE
} ISensLogon2Vtbl;

interface ISensLogon2 {
    CONST_VTBL ISensLogon2Vtbl* lpVtbl;
};

#ifdef COBJMACROS
#ifndef WIDL_C_INLINE_WRAPPERS
/*** IUnknown methods ***/
#define ISensLogon2_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define ISensLogon2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ISensLogon2_Release(This) (This)->lpVtbl->Release(This)
/*** IDispatch methods ***/
#define ISensLogon2_GetTypeInfoCount(This,pctinfo) (This)->lpVtbl->GetTypeInfoCount(This,pctinfo)
#define ISensLogon2_GetTypeInfo(This,iTInfo,lcid,ppTInfo) (This)->lpVtbl->GetTypeInfo(This,iTInfo,lcid,ppTInfo)
#define ISensLogon2_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) (This)->lpVtbl->GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)
#define ISensLogon2_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) (This)->lpVtbl->Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)
/*** ISensLogon2 methods ***/
#define ISensLogon2_Logon(This,bstrUserName,dwSessionId) (This)->lpVtbl->Logon(This,bstrUserName,dwSessionId)
#define ISensLogon2_Logoff(This,bstrUserName,dwSessionId) (This)->lpVtbl->Logoff(This,bstrUserName,dwSessionId)
#define ISensLogon2_SessionDisconnect(This,bstrUserName,dwSessionId) (This)->lpVtbl->SessionDisconnect(This,bstrUserName,dwSessionId)
#define ISensLogon2_SessionReconnect(This,bstrUserName,dwSessionId) (This)->lpVtbl->SessionReconnect(This,bstrUserName,dwSessionId)
#define ISensLogon2_PostShell(This,bstrUserName,dwSessionId) (This)->lpVtbl->PostShell(This,bstrUserName,dwSessionId)
#else
/*** IUnknown methods ***/
static FORCEINLINE HRESULT ISensLogon2_QueryInterface(ISensLogon2* This,REFIID riid,void **ppvObject) {
    return This->lpVtbl->QueryInterface(This,riid,ppvObject);
}
static FORCEINLINE ULONG ISensLogon2_AddRef(ISensLogon2* This) {
    return This->lpVtbl->AddRef(This);
}
static FORCEINLINE ULONG ISensLogon2_Release(ISensLogon2* This) {
    return This->lpVtbl->Release(This);
}
/*** IDispatch methods ***/
static FORCEINLINE HRESULT ISensLogon2_GetTypeInfoCount(ISensLogon2* This,UINT *pctinfo) {
    return This->lpVtbl->GetTypeInfoCount(This,pctinfo);
}
static FORCEINLINE HRESULT ISensLogon2_GetTypeInfo(ISensLogon2* This,UINT iTInfo,LCID lcid,ITypeInfo **ppTInfo) {
    return This->lpVtbl->GetTypeInfo(This,iTInfo,lcid,ppTInfo);
}
static FORCEINLINE HRESULT ISensLogon2_GetIDsOfNames(ISensLogon2* This,REFIID riid,LPOLESTR *rgszNames,UINT cNames,LCID lcid,DISPID *rgDispId) {
    return This->lpVtbl->GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId);
}
static FORCEINLINE HRESULT ISensLogon2_Invoke(ISensLogon2* This,DISPID dispIdMember,REFIID riid,LCID lcid,WORD wFlags,DISPPARAMS *pDispParams,VARIANT *pVarResult,EXCEPINFO *pExcepInfo,UINT *puArgErr) {
    return This->lpVtbl->Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr);
}
/*** ISensLogon2 methods ***/
static FORCEINLINE HRESULT ISensLogon2_Logon(ISensLogon2* This,BSTR bstrUserName,DWORD dwSessionId) {
    return This->lpVtbl->Logon(This,bstrUserName,dwSessionId);
}
static FORCEINLINE HRESULT ISensLogon2_Logoff(ISensLogon2* This,BSTR bstrUserName,DWORD dwSessionId) {
    return This->lpVtbl->Logoff(This,bstrUserName,dwSessionId);
}
static FORCEINLINE HRESULT ISensLogon2_SessionDisconnect(ISensLogon2* This,BSTR bstrUserName,DWORD dwSessionId) {
    return This->lpVtbl->SessionDisconnect(This,bstrUserName,dwSessionId);
}
static FORCEINLINE HRESULT ISensLogon2_SessionReconnect(ISensLogon2* This,BSTR bstrUserName,DWORD dwSessionId) {
    return This->lpVtbl->SessionReconnect(This,bstrUserName,dwSessionId);
}
static FORCEINLINE HRESULT ISensLogon2_PostShell(ISensLogon2* This,BSTR bstrUserName,DWORD dwSessionId) {
    return This->lpVtbl->PostShell(This,bstrUserName,dwSessionId);
}
#endif
#endif

#endif

HRESULT STDMETHODCALLTYPE ISensLogon2_Logon_Proxy(
    ISensLogon2* This,
    BSTR bstrUserName,
    DWORD dwSessionId);
void __RPC_STUB ISensLogon2_Logon_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE ISensLogon2_Logoff_Proxy(
    ISensLogon2* This,
    BSTR bstrUserName,
    DWORD dwSessionId);
void __RPC_STUB ISensLogon2_Logoff_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE ISensLogon2_SessionDisconnect_Proxy(
    ISensLogon2* This,
    BSTR bstrUserName,
    DWORD dwSessionId);
void __RPC_STUB ISensLogon2_SessionDisconnect_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE ISensLogon2_SessionReconnect_Proxy(
    ISensLogon2* This,
    BSTR bstrUserName,
    DWORD dwSessionId);
void __RPC_STUB ISensLogon2_SessionReconnect_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);
HRESULT STDMETHODCALLTYPE ISensLogon2_PostShell_Proxy(
    ISensLogon2* This,
    BSTR bstrUserName,
    DWORD dwSessionId);
void __RPC_STUB ISensLogon2_PostShell_Stub(
    IRpcStubBuffer* This,
    IRpcChannelBuffer* pRpcChannelBuffer,
    PRPC_MESSAGE pRpcMessage,
    DWORD* pdwStubPhase);

#endif  /* __ISensLogon2_INTERFACE_DEFINED__ */

/* Begin additional prototypes for all interfaces */

ULONG           __RPC_USER BSTR_UserSize     (ULONG *, ULONG, BSTR *);
unsigned char * __RPC_USER BSTR_UserMarshal  (ULONG *, unsigned char *, BSTR *);
unsigned char * __RPC_USER BSTR_UserUnmarshal(ULONG *, unsigned char *, BSTR *);
void            __RPC_USER BSTR_UserFree     (ULONG *, BSTR *);

/* End additional prototypes */

#ifdef __cplusplus
}
#endif

#endif /* __sensevts_h__ */
