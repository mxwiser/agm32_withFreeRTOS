#ifndef __RINGBUFF_H__
#define __RINGBUFF_H__

#ifndef int8
typedef signed   char   int8;
typedef unsigned char   uint8;
typedef signed   short  int16;
typedef unsigned short  uint16;
typedef signed   long   int32;
typedef unsigned long   uint32;
typedef signed   long long  int64;
typedef unsigned long long  uint64;
#endif


typedef enum {
    HY_SUCCESS = 0,
    HY_FAIL = 1
} HY_TYPE_LOGIC;

#define HY_ASSERT(x)


typedef struct _RINGBUF{
    uint32 read, write;  
	uint8* pool;
	uint32 poolSize;
	uint8 initialFlag;
}HY_RINGBUF;

/*
extern int StrBufXNCmp( unsigned char* str, unsigned char* buf, unsigned int len );
*/
extern HY_TYPE_LOGIC HY_RingBuf_Init(HY_RINGBUF* rb, uint8* pool, uint32 poolSize);
extern uint32 HY_RingBuf_Read(HY_RINGBUF* rb, uint8* readData, uint32 length);
extern HY_TYPE_LOGIC HY_RingBuf_Write(HY_RINGBUF* rb, uint8* writeData, uint32 length);
extern uint32 HY_RingBuf_Get_Len(HY_RINGBUF* rb);


#endif //__RINGBUFF_H__

