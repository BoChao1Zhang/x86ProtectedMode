	#include "os.h"

	// 声明本地以下符号是全局的，在其它源文件中可以访问
	.global _start

	// 指定以下的代码生成16位的机器指令，这样才能在启动时的实模式下运行
  	.code16

	// 以下是代码区
 	.text
_start:
	// ds寄存器指向数据段
	mov $0x0, %ax
	mov %ax, %ds // 数据段寄存器
	mov %ax, %ss // 栈段寄存器
	mov %ax, %es // 附加段寄存器

	mov $_start, %esp // start位于0x7c00，栈顶指向0x7c00

read_self_all:
	mov $_start_32, %bx
	mov $0x2, %cx
	mov $0x240, %ax // ah表示功能号 al表示扇区数
	mov $0x80, %dx
	int $0x13

	jc read_self_all

	// 进入保护模式
	cli
	lgdt gdt_desc
	mov $1, %eax
	lmsw %ax // 设置CR0为1,进入保护模式
	jmp $KERNEL_CODE_SEG, $_start_32



	.org 0x1fe // 10进制对应510
	.byte 0x55,0xaa // 启动程序标志

	.code32
	.text
_start_32:
	mov $KERNEL_DATA_SEG, %ax
	mov %ax, %ds
	mov %ax, %es
	mov %ax, %ss
	mov $_start, %esp

	jmp .



gdt_desc:
	.word (256* 8) - 1 //表示GDT表的界限
	.long gdt_table