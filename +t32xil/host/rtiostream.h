//!< @file rtiostream.h
//!< Copyright (c) 2012-2021 Lauterbach GmbH

#pragma once

#define DLL_PUBLIC_API  __declspec(dllexport)

DLL_PUBLIC_API int rtIOStreamOpen(int argc, void *argv[]);
DLL_PUBLIC_API int rtIOStreamSend(int streamID, const void *src, size_t size, size_t *sizeSent);
DLL_PUBLIC_API int rtIOStreamRecv(int streamID, void *dst, size_t size, size_t *sizeRecvd);
DLL_PUBLIC_API int rtIOStreamClose(int streamID);

DLL_PUBLIC_API int debugioOpen(int argc, void *argv[]);
DLL_PUBLIC_API int debugioClose(void);
