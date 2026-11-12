
#include "FreeRTOS.h"
#include "ringBuff.h"
#include <string.h>


// ***********************************************************************
// name: HY_RingBuf_Init
// fun: 初始化ringbuf
// input: rb 句柄  pool buf空间 poolSize buf长度(byte)
// output：SUCCESS OR FAIL
// ***********************************************************************
extern HY_TYPE_LOGIC HY_RingBuf_Init(HY_RINGBUF* rb, uint8* pool, uint32 poolSize)
{
	HY_TYPE_LOGIC rv;

	if( (NULL == rb) || (NULL == pool) || (0 == poolSize)){
		rv = HY_FAIL;
		HY_ASSERT(0);
	}else{
		rb->pool = pool;
		rb->poolSize = poolSize;
		rb->read = 0;
		rb->write = 0;	
		rb->initialFlag = 1;
		rv = HY_SUCCESS;
	}
	
	return rv;
}

// ***********************************************************************
// name: HY_RingBuf_Get_Len
// fun: 获取ringbuf内的数据长度
// input: rb 句柄  pool buf空间 poolSize buf长度(byte)
// output：SUCCESS OR FAIL
// ***********************************************************************
extern uint32 HY_RingBuf_Get_Len(HY_RINGBUF* rb)
{
	int32 actLen;
	actLen = 0;

	HY_ASSERT(rb->read <= rb->poolSize);
	HY_ASSERT(rb->write <= rb->poolSize);

	actLen = rb->write - rb->read;
	if( 0 > actLen ){
		actLen += rb->poolSize;
	}

	return ((uint32)actLen);
}

// ***********************************************************************
// name: HY_RingBuf_Read
// fun: 读取ringbuf内的内容
// input: rb 句柄  pool buf空间 poolSize buf长度(byte)
// output：实际读取的长度
// ***********************************************************************
extern uint32 HY_RingBuf_Read(HY_RINGBUF* rb, uint8* readData, uint32 length)
{
	uint32 actLen,copyLen,remainLen;
	//uint32 i;

	if( 0 == rb ){
		HY_ASSERT(rb);
		return 0;
	}

	if( 0 == readData ){
		HY_ASSERT(readData);
		return 0;
	}
	if( 1 != rb->initialFlag){
		return 0;
	}
	HY_ASSERT(rb->read <= rb->poolSize);
	HY_ASSERT(rb->write <= rb->poolSize);

	// 获取需要拷贝的长度
	actLen = HY_RingBuf_Get_Len(rb);
	actLen = actLen > length ? length : actLen;
	if( 0 == actLen ){
		return 0;
	}
	copyLen = ((rb->read + actLen ) <= rb->poolSize) ? actLen : (rb->poolSize-rb->read);
	remainLen = actLen - copyLen;
	
	memcpy(readData, rb->pool+rb->read, copyLen);
	if( remainLen ){
		memcpy(readData+copyLen, rb->pool, remainLen);	
	}
	rb->read += copyLen+remainLen;
	rb->read %= rb->poolSize;

	return actLen;
}

// ***********************************************************************
// name: HY_RingBuf_Write
// fun: 读取ringbuf内的内容
// input: rb 句柄  pool buf空间 poolSize buf长度(byte)
// output：实际读取的长度
// ***********************************************************************
extern HY_TYPE_LOGIC HY_RingBuf_Write(HY_RINGBUF* rb, uint8* writeData, uint32 length)
{
	uint32 bufAvail,copyLen,remainLen;

	if( 0 == rb ){
		HY_ASSERT(writeData);
		return HY_FAIL;
	}
	
	if( 0 == writeData ){
		HY_ASSERT(writeData);
		return HY_FAIL;
	}

	if( 1 != rb->initialFlag ){
		return HY_FAIL;
	}

	HY_ASSERT(rb->read <= rb->poolSize);
	HY_ASSERT(rb->write <= rb->poolSize);

	bufAvail = rb->poolSize - HY_RingBuf_Get_Len(rb);
	if( bufAvail < length ){
		return HY_FAIL;
	}else{
		
		copyLen = ((rb->write + length ) <= rb->poolSize) ? length : (rb->poolSize-rb->write);
        remainLen = length - copyLen;
        
        memcpy( rb->pool+rb->write,writeData, copyLen);
        if( remainLen ){
            memcpy(rb->pool,writeData+copyLen, remainLen);	
        }
        rb->write += copyLen+remainLen;
        rb->write %= rb->poolSize;
	}

	return HY_SUCCESS;
}

