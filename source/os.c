/**
 * 功能：32位代码，完成多任务的运行
 *
 *创建时间：2022年8月31日
 *作者：李述铜
 *联系邮箱: 527676163@qq.com
 *相关信息：此工程为《从0写x86 Linux操作系统》的前置课程，用于帮助预先建立对32位x86体系结构的理解。整体代码量不到200行（不算注释）
 *课程请见：https://study.163.com/course/introduction.htm?courseId=1212765805&_trace_c_p_k2_=0bdf1e7edda543a8b9a0ad73b5100990
 */
#include "os.h"

typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;


//全局描述符表
struct{uint16_t limit_l,base_l,base_m_attr, base_limit;}gdt_table[256] __attribute__((aligned(8))) = {
    //内核代码段基地址从0开始，大小为4GB，段粒度为4KB，段类型为代码段，特权级为0，不允许访问，不允许写入，不允许扩展方向，不允许执行
    [KERNEL_CODE_SEG / 8] = {0xffff, 0x0000,0x9a00,0xcf00},
    [KERNEL_DATA_SEG / 8] = {0xffff, 0x0000,0x9200,0xcf00},
};

