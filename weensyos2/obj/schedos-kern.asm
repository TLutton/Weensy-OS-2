
obj/schedos-kern:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4 bc                	in     $0xbc,%al

0010000c <multiboot_start>:
# The multiboot_start routine sets the stack pointer to the top of the
# SchedOS's kernel stack, then jumps to the 'start' routine in schedos-kern.c.

.globl multiboot_start
multiboot_start:
	movl $0x180000, %esp
  10000c:	bc 00 00 18 00       	mov    $0x180000,%esp
	pushl $0
  100011:	6a 00                	push   $0x0
	popfl
  100013:	9d                   	popf   
	call start
  100014:	e8 78 01 00 00       	call   100191 <start>
  100019:	90                   	nop

0010001a <clock_int_handler>:
# Interrupt handlers
.align 2

	.globl clock_int_handler
clock_int_handler:
	pushl $0		// error code
  10001a:	6a 00                	push   $0x0
	pushl $32		// trap number
  10001c:	6a 20                	push   $0x20
	jmp _generic_int_handler
  10001e:	eb 40                	jmp    100060 <_generic_int_handler>

00100020 <sys_int48_handler>:

sys_int48_handler:
	pushl $0
  100020:	6a 00                	push   $0x0
	pushl $48
  100022:	6a 30                	push   $0x30
	jmp _generic_int_handler
  100024:	eb 3a                	jmp    100060 <_generic_int_handler>

00100026 <sys_int49_handler>:

sys_int49_handler:
	pushl $0
  100026:	6a 00                	push   $0x0
	pushl $49
  100028:	6a 31                	push   $0x31
	jmp _generic_int_handler
  10002a:	eb 34                	jmp    100060 <_generic_int_handler>

0010002c <sys_int50_handler>:

sys_int50_handler:
	pushl $0
  10002c:	6a 00                	push   $0x0
	pushl $50
  10002e:	6a 32                	push   $0x32
	jmp _generic_int_handler
  100030:	eb 2e                	jmp    100060 <_generic_int_handler>

00100032 <sys_int51_handler>:

sys_int51_handler:
	pushl $0
  100032:	6a 00                	push   $0x0
	pushl $51
  100034:	6a 33                	push   $0x33
	jmp _generic_int_handler
  100036:	eb 28                	jmp    100060 <_generic_int_handler>

00100038 <sys_int52_handler>:

sys_int52_handler:
	pushl $0
  100038:	6a 00                	push   $0x0
	pushl $52
  10003a:	6a 34                	push   $0x34
	jmp _generic_int_handler
  10003c:	eb 22                	jmp    100060 <_generic_int_handler>

0010003e <sys_int53_handler>:

sys_int53_handler:
	pushl $0
  10003e:	6a 00                	push   $0x0
	pushl $53
  100040:	6a 35                	push   $0x35
	jmp _generic_int_handler
  100042:	eb 1c                	jmp    100060 <_generic_int_handler>

00100044 <sys_int54_handler>:

sys_int54_handler:
	pushl $0
  100044:	6a 00                	push   $0x0
	pushl $54
  100046:	6a 36                	push   $0x36
	jmp _generic_int_handler
  100048:	eb 16                	jmp    100060 <_generic_int_handler>

0010004a <sys_int55_handler>:

sys_int55_handler:
	pushl $0
  10004a:	6a 00                	push   $0x0
	pushl $55
  10004c:	6a 37                	push   $0x37
	jmp _generic_int_handler
  10004e:	eb 10                	jmp    100060 <_generic_int_handler>

00100050 <sys_int56_handler>:

sys_int56_handler:
	pushl $0
  100050:	6a 00                	push   $0x0
	pushl $56
  100052:	6a 38                	push   $0x38
	jmp _generic_int_handler
  100054:	eb 0a                	jmp    100060 <_generic_int_handler>

00100056 <sys_int57_handler>:

sys_int57_handler:
	pushl $0
  100056:	6a 00                	push   $0x0
	pushl $57
  100058:	6a 39                	push   $0x39
	jmp _generic_int_handler
  10005a:	eb 04                	jmp    100060 <_generic_int_handler>

0010005c <default_int_handler>:

	.globl default_int_handler
default_int_handler:
	pushl $0
  10005c:	6a 00                	push   $0x0
	jmp _generic_int_handler
  10005e:	eb 00                	jmp    100060 <_generic_int_handler>

00100060 <_generic_int_handler>:
	# When we get here, the processor's interrupt mechanism has
	# pushed the old task status and stack registers onto the kernel stack.
	# Then one of the specific handlers pushed the trap number.
	# Now, we complete the 'registers_t' structure by pushing the extra
	# segment definitions and the general CPU registers.
	pushl %ds
  100060:	1e                   	push   %ds
	pushl %es
  100061:	06                   	push   %es
	pushal
  100062:	60                   	pusha  

	# Load the kernel's data segments into the extra segment registers
	# (although we don't use those extra segments!).
	movl $0x10, %eax
  100063:	b8 10 00 00 00       	mov    $0x10,%eax
	movw %ax, %ds
  100068:	8e d8                	mov    %eax,%ds
	movw %ax, %es
  10006a:	8e c0                	mov    %eax,%es

	# Call the kernel's 'interrupt' function.
	pushl %esp
  10006c:	54                   	push   %esp
	call interrupt
  10006d:	e8 ae 00 00 00       	call   100120 <interrupt>

00100072 <sys_int_handlers>:
  100072:	20 00                	and    %al,(%eax)
  100074:	10 00                	adc    %al,(%eax)
  100076:	26 00 10             	add    %dl,%es:(%eax)
  100079:	00 2c 00             	add    %ch,(%eax,%eax,1)
  10007c:	10 00                	adc    %al,(%eax)
  10007e:	32 00                	xor    (%eax),%al
  100080:	10 00                	adc    %al,(%eax)
  100082:	38 00                	cmp    %al,(%eax)
  100084:	10 00                	adc    %al,(%eax)
  100086:	3e 00 10             	add    %dl,%ds:(%eax)
  100089:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
  10008d:	00 4a 00             	add    %cl,0x0(%edx)
  100090:	10 00                	adc    %al,(%eax)
  100092:	50                   	push   %eax
  100093:	00 10                	add    %dl,(%eax)
  100095:	00 56 00             	add    %dl,0x0(%esi)
  100098:	10 00                	adc    %al,(%eax)
  10009a:	90                   	nop
  10009b:	90                   	nop

0010009c <schedule>:
 *
 *****************************************************************************/

void
schedule(void)
{
  10009c:	83 ec 0c             	sub    $0xc,%esp
	pid_t pid = current->p_pid;
  10009f:	a1 2c 7a 10 00       	mov    0x107a2c,%eax
  1000a4:	8b 10                	mov    (%eax),%edx

	if (scheduling_algorithm == 0)
  1000a6:	a1 30 7a 10 00       	mov    0x107a30,%eax
  1000ab:	85 c0                	test   %eax,%eax
  1000ad:	75 1c                	jne    1000cb <schedule+0x2f>
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000af:	b9 05 00 00 00       	mov    $0x5,%ecx
  1000b4:	8d 42 01             	lea    0x1(%edx),%eax
  1000b7:	99                   	cltd   
  1000b8:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000ba:	6b c2 50             	imul   $0x50,%edx,%eax
  1000bd:	83 b8 7c 70 10 00 01 	cmpl   $0x1,0x10707c(%eax)
  1000c4:	75 ee                	jne    1000b4 <schedule+0x18>
				run(&proc_array[pid]);
  1000c6:	83 ec 0c             	sub    $0xc,%esp
  1000c9:	eb 1b                	jmp    1000e6 <schedule+0x4a>
		}
	else if(scheduling_algorithm == 1) // Exercise 2
  1000cb:	83 f8 01             	cmp    $0x1,%eax
  1000ce:	75 2f                	jne    1000ff <schedule+0x63>
  1000d0:	30 c0                	xor    %al,%al
  1000d2:	31 d2                	xor    %edx,%edx
		while(1) 
			for(pid = 0; pid < NPROCS; pid++) 
				if(proc_array[pid].p_state == P_RUNNABLE)
  1000d4:	6b ca 50             	imul   $0x50,%edx,%ecx
  1000d7:	83 b9 7c 70 10 00 01 	cmpl   $0x1,0x10707c(%ecx)
  1000de:	75 11                	jne    1000f1 <schedule+0x55>
					run(&proc_array[pid]);
  1000e0:	6b c0 50             	imul   $0x50,%eax,%eax
  1000e3:	83 ec 0c             	sub    $0xc,%esp
  1000e6:	05 34 70 10 00       	add    $0x107034,%eax
  1000eb:	50                   	push   %eax
  1000ec:	e8 b4 03 00 00       	call   1004a5 <run>
			if (proc_array[pid].p_state == P_RUNNABLE)
				run(&proc_array[pid]);
		}
	else if(scheduling_algorithm == 1) // Exercise 2
		while(1) 
			for(pid = 0; pid < NPROCS; pid++) 
  1000f1:	8d 42 01             	lea    0x1(%edx),%eax
  1000f4:	83 f8 04             	cmp    $0x4,%eax
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
				run(&proc_array[pid]);
		}
	else if(scheduling_algorithm == 1) // Exercise 2
  1000f7:	89 c2                	mov    %eax,%edx
		while(1) 
			for(pid = 0; pid < NPROCS; pid++) 
  1000f9:	7e d9                	jle    1000d4 <schedule+0x38>
  1000fb:	31 c0                	xor    %eax,%eax
  1000fd:	eb d3                	jmp    1000d2 <schedule+0x36>
					run(&proc_array[pid]);
			
		

	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  1000ff:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100105:	50                   	push   %eax
  100106:	68 64 0a 10 00       	push   $0x100a64
  10010b:	68 00 01 00 00       	push   $0x100
  100110:	52                   	push   %edx
  100111:	e8 34 09 00 00       	call   100a4a <console_printf>
  100116:	83 c4 10             	add    $0x10,%esp
  100119:	a3 00 80 19 00       	mov    %eax,0x198000
  10011e:	eb fe                	jmp    10011e <schedule+0x82>

00100120 <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100120:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100121:	a1 2c 7a 10 00       	mov    0x107a2c,%eax
  100126:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  10012b:	56                   	push   %esi
  10012c:	53                   	push   %ebx
  10012d:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100131:	8d 78 04             	lea    0x4(%eax),%edi
  100134:	89 de                	mov    %ebx,%esi
  100136:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  100138:	8b 53 28             	mov    0x28(%ebx),%edx
  10013b:	83 fa 31             	cmp    $0x31,%edx
  10013e:	74 1f                	je     10015f <interrupt+0x3f>
  100140:	77 0c                	ja     10014e <interrupt+0x2e>
  100142:	83 fa 20             	cmp    $0x20,%edx
  100145:	74 43                	je     10018a <interrupt+0x6a>
  100147:	83 fa 30             	cmp    $0x30,%edx
  10014a:	74 0e                	je     10015a <interrupt+0x3a>
  10014c:	eb 41                	jmp    10018f <interrupt+0x6f>
  10014e:	83 fa 32             	cmp    $0x32,%edx
  100151:	74 23                	je     100176 <interrupt+0x56>
  100153:	83 fa 33             	cmp    $0x33,%edx
  100156:	74 29                	je     100181 <interrupt+0x61>
  100158:	eb 35                	jmp    10018f <interrupt+0x6f>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  10015a:	e8 3d ff ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  10015f:	a1 2c 7a 10 00       	mov    0x107a2c,%eax
		current->p_exit_status = reg->reg_eax;
  100164:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100167:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  10016e:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  100171:	e8 26 ff ff ff       	call   10009c <schedule>

	case INT_SYS_USER1:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		run(current);
  100176:	83 ec 0c             	sub    $0xc,%esp
  100179:	ff 35 2c 7a 10 00    	pushl  0x107a2c
  10017f:	eb 04                	jmp    100185 <interrupt+0x65>

	case INT_SYS_USER2:
		/* Your code here (if you want). */
		run(current);
  100181:	83 ec 0c             	sub    $0xc,%esp
  100184:	50                   	push   %eax
  100185:	e8 1b 03 00 00       	call   1004a5 <run>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  10018a:	e8 0d ff ff ff       	call   10009c <schedule>
  10018f:	eb fe                	jmp    10018f <interrupt+0x6f>

00100191 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  100191:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100192:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  100197:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100198:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  10019a:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10019b:	bb 84 70 10 00       	mov    $0x107084,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  1001a0:	e8 df 00 00 00       	call   100284 <segments_init>
	interrupt_controller_init(0);
  1001a5:	83 ec 0c             	sub    $0xc,%esp
  1001a8:	6a 00                	push   $0x0
  1001aa:	e8 d0 01 00 00       	call   10037f <interrupt_controller_init>
	console_clear();
  1001af:	e8 54 02 00 00       	call   100408 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  1001b4:	83 c4 0c             	add    $0xc,%esp
  1001b7:	68 90 01 00 00       	push   $0x190
  1001bc:	6a 00                	push   $0x0
  1001be:	68 34 70 10 00       	push   $0x107034
  1001c3:	e8 20 04 00 00       	call   1005e8 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001c8:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1001cb:	c7 05 34 70 10 00 00 	movl   $0x0,0x107034
  1001d2:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1001d5:	c7 05 7c 70 10 00 00 	movl   $0x0,0x10707c
  1001dc:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1001df:	c7 05 84 70 10 00 01 	movl   $0x1,0x107084
  1001e6:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1001e9:	c7 05 cc 70 10 00 00 	movl   $0x0,0x1070cc
  1001f0:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1001f3:	c7 05 d4 70 10 00 02 	movl   $0x2,0x1070d4
  1001fa:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1001fd:	c7 05 1c 71 10 00 00 	movl   $0x0,0x10711c
  100204:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100207:	c7 05 24 71 10 00 03 	movl   $0x3,0x107124
  10020e:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100211:	c7 05 6c 71 10 00 00 	movl   $0x0,0x10716c
  100218:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10021b:	c7 05 74 71 10 00 04 	movl   $0x4,0x107174
  100222:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100225:	c7 05 bc 71 10 00 00 	movl   $0x0,0x1071bc
  10022c:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  10022f:	83 ec 0c             	sub    $0xc,%esp
  100232:	53                   	push   %ebx
  100233:	e8 84 02 00 00       	call   1004bc <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100238:	58                   	pop    %eax
  100239:	5a                   	pop    %edx
  10023a:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  10023d:	89 7b 40             	mov    %edi,0x40(%ebx)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100240:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100246:	50                   	push   %eax
  100247:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100248:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100249:	e8 aa 02 00 00       	call   1004f8 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  10024e:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100251:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)
  100258:	83 c3 50             	add    $0x50,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  10025b:	83 fe 04             	cmp    $0x4,%esi
  10025e:	75 cf                	jne    10022f <start+0x9e>
	// Initialize the scheduling algorithm.
	//scheduling_algorithm = 0;
	scheduling_algorithm = 1;

	// Switch to the first process.
	run(&proc_array[1]);
  100260:	83 ec 0c             	sub    $0xc,%esp
  100263:	68 84 70 10 00       	push   $0x107084
		proc->p_state = P_RUNNABLE;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  100268:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  10026f:	80 0b 00 

	// Initialize the scheduling algorithm.
	//scheduling_algorithm = 0;
	scheduling_algorithm = 1;
  100272:	c7 05 30 7a 10 00 01 	movl   $0x1,0x107a30
  100279:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  10027c:	e8 24 02 00 00       	call   1004a5 <run>
  100281:	90                   	nop
  100282:	90                   	nop
  100283:	90                   	nop

00100284 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100284:	b8 c4 71 10 00       	mov    $0x1071c4,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100289:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10028e:	89 c2                	mov    %eax,%edx
  100290:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  100293:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100294:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  100299:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10029c:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  1002a2:	c1 e8 18             	shr    $0x18,%eax
  1002a5:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002ab:	ba 2c 72 10 00       	mov    $0x10722c,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002b0:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002b5:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002b7:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  1002be:	68 00 
  1002c0:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1002c7:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  1002ce:	c7 05 c8 71 10 00 00 	movl   $0x180000,0x1071c8
  1002d5:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  1002d8:	66 c7 05 cc 71 10 00 	movw   $0x10,0x1071cc
  1002df:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002e1:	66 89 0c c5 2c 72 10 	mov    %cx,0x10722c(,%eax,8)
  1002e8:	00 
  1002e9:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1002f0:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1002f5:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  1002fa:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  1002ff:	40                   	inc    %eax
  100300:	3d 00 01 00 00       	cmp    $0x100,%eax
  100305:	75 da                	jne    1002e1 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100307:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  10030c:	ba 2c 72 10 00       	mov    $0x10722c,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100311:	66 a3 2c 73 10 00    	mov    %ax,0x10732c
  100317:	c1 e8 10             	shr    $0x10,%eax
  10031a:	66 a3 32 73 10 00    	mov    %ax,0x107332
  100320:	b8 30 00 00 00       	mov    $0x30,%eax
  100325:	66 c7 05 2e 73 10 00 	movw   $0x8,0x10732e
  10032c:	08 00 
  10032e:	c6 05 30 73 10 00 00 	movb   $0x0,0x107330
  100335:	c6 05 31 73 10 00 8e 	movb   $0x8e,0x107331

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  10033c:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  100343:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  10034a:	66 89 0c c5 2c 72 10 	mov    %cx,0x10722c(,%eax,8)
  100351:	00 
  100352:	c1 e9 10             	shr    $0x10,%ecx
  100355:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10035a:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  10035f:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  100364:	40                   	inc    %eax
  100365:	83 f8 3a             	cmp    $0x3a,%eax
  100368:	75 d2                	jne    10033c <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  10036a:	b0 28                	mov    $0x28,%al
  10036c:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  100373:	0f 00 d8             	ltr    %ax
  100376:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  10037d:	5b                   	pop    %ebx
  10037e:	c3                   	ret    

0010037f <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  10037f:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100380:	b0 ff                	mov    $0xff,%al
  100382:	57                   	push   %edi
  100383:	56                   	push   %esi
  100384:	53                   	push   %ebx
  100385:	bb 21 00 00 00       	mov    $0x21,%ebx
  10038a:	89 da                	mov    %ebx,%edx
  10038c:	ee                   	out    %al,(%dx)
  10038d:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  100392:	89 ca                	mov    %ecx,%edx
  100394:	ee                   	out    %al,(%dx)
  100395:	be 11 00 00 00       	mov    $0x11,%esi
  10039a:	bf 20 00 00 00       	mov    $0x20,%edi
  10039f:	89 f0                	mov    %esi,%eax
  1003a1:	89 fa                	mov    %edi,%edx
  1003a3:	ee                   	out    %al,(%dx)
  1003a4:	b0 20                	mov    $0x20,%al
  1003a6:	89 da                	mov    %ebx,%edx
  1003a8:	ee                   	out    %al,(%dx)
  1003a9:	b0 04                	mov    $0x4,%al
  1003ab:	ee                   	out    %al,(%dx)
  1003ac:	b0 03                	mov    $0x3,%al
  1003ae:	ee                   	out    %al,(%dx)
  1003af:	bd a0 00 00 00       	mov    $0xa0,%ebp
  1003b4:	89 f0                	mov    %esi,%eax
  1003b6:	89 ea                	mov    %ebp,%edx
  1003b8:	ee                   	out    %al,(%dx)
  1003b9:	b0 28                	mov    $0x28,%al
  1003bb:	89 ca                	mov    %ecx,%edx
  1003bd:	ee                   	out    %al,(%dx)
  1003be:	b0 02                	mov    $0x2,%al
  1003c0:	ee                   	out    %al,(%dx)
  1003c1:	b0 01                	mov    $0x1,%al
  1003c3:	ee                   	out    %al,(%dx)
  1003c4:	b0 68                	mov    $0x68,%al
  1003c6:	89 fa                	mov    %edi,%edx
  1003c8:	ee                   	out    %al,(%dx)
  1003c9:	be 0a 00 00 00       	mov    $0xa,%esi
  1003ce:	89 f0                	mov    %esi,%eax
  1003d0:	ee                   	out    %al,(%dx)
  1003d1:	b0 68                	mov    $0x68,%al
  1003d3:	89 ea                	mov    %ebp,%edx
  1003d5:	ee                   	out    %al,(%dx)
  1003d6:	89 f0                	mov    %esi,%eax
  1003d8:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  1003d9:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  1003de:	89 da                	mov    %ebx,%edx
  1003e0:	19 c0                	sbb    %eax,%eax
  1003e2:	f7 d0                	not    %eax
  1003e4:	05 ff 00 00 00       	add    $0xff,%eax
  1003e9:	ee                   	out    %al,(%dx)
  1003ea:	b0 ff                	mov    $0xff,%al
  1003ec:	89 ca                	mov    %ecx,%edx
  1003ee:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  1003ef:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  1003f4:	74 0d                	je     100403 <interrupt_controller_init+0x84>
  1003f6:	b2 43                	mov    $0x43,%dl
  1003f8:	b0 34                	mov    $0x34,%al
  1003fa:	ee                   	out    %al,(%dx)
  1003fb:	b0 9c                	mov    $0x9c,%al
  1003fd:	b2 40                	mov    $0x40,%dl
  1003ff:	ee                   	out    %al,(%dx)
  100400:	b0 2e                	mov    $0x2e,%al
  100402:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  100403:	5b                   	pop    %ebx
  100404:	5e                   	pop    %esi
  100405:	5f                   	pop    %edi
  100406:	5d                   	pop    %ebp
  100407:	c3                   	ret    

00100408 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100408:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100409:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  10040b:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  10040c:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100413:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  100416:	8b 15 00 80 19 00    	mov    0x198000,%edx
  10041c:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  100422:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  100425:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  10042a:	75 ea                	jne    100416 <console_clear+0xe>
  10042c:	be d4 03 00 00       	mov    $0x3d4,%esi
  100431:	b0 0e                	mov    $0xe,%al
  100433:	89 f2                	mov    %esi,%edx
  100435:	ee                   	out    %al,(%dx)
  100436:	31 c9                	xor    %ecx,%ecx
  100438:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  10043d:	88 c8                	mov    %cl,%al
  10043f:	89 da                	mov    %ebx,%edx
  100441:	ee                   	out    %al,(%dx)
  100442:	b0 0f                	mov    $0xf,%al
  100444:	89 f2                	mov    %esi,%edx
  100446:	ee                   	out    %al,(%dx)
  100447:	88 c8                	mov    %cl,%al
  100449:	89 da                	mov    %ebx,%edx
  10044b:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  10044c:	5b                   	pop    %ebx
  10044d:	5e                   	pop    %esi
  10044e:	c3                   	ret    

0010044f <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  10044f:	ba 64 00 00 00       	mov    $0x64,%edx
  100454:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100455:	a8 01                	test   $0x1,%al
  100457:	74 45                	je     10049e <console_read_digit+0x4f>
  100459:	b2 60                	mov    $0x60,%dl
  10045b:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  10045c:	8d 50 fe             	lea    -0x2(%eax),%edx
  10045f:	80 fa 08             	cmp    $0x8,%dl
  100462:	77 05                	ja     100469 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  100464:	0f b6 c0             	movzbl %al,%eax
  100467:	48                   	dec    %eax
  100468:	c3                   	ret    
	else if (data == 0x0B)
  100469:	3c 0b                	cmp    $0xb,%al
  10046b:	74 35                	je     1004a2 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  10046d:	8d 50 b9             	lea    -0x47(%eax),%edx
  100470:	80 fa 02             	cmp    $0x2,%dl
  100473:	77 07                	ja     10047c <console_read_digit+0x2d>
		return data - 0x47 + 7;
  100475:	0f b6 c0             	movzbl %al,%eax
  100478:	83 e8 40             	sub    $0x40,%eax
  10047b:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  10047c:	8d 50 b5             	lea    -0x4b(%eax),%edx
  10047f:	80 fa 02             	cmp    $0x2,%dl
  100482:	77 07                	ja     10048b <console_read_digit+0x3c>
		return data - 0x4B + 4;
  100484:	0f b6 c0             	movzbl %al,%eax
  100487:	83 e8 47             	sub    $0x47,%eax
  10048a:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  10048b:	8d 50 b1             	lea    -0x4f(%eax),%edx
  10048e:	80 fa 02             	cmp    $0x2,%dl
  100491:	77 07                	ja     10049a <console_read_digit+0x4b>
		return data - 0x4F + 1;
  100493:	0f b6 c0             	movzbl %al,%eax
  100496:	83 e8 4e             	sub    $0x4e,%eax
  100499:	c3                   	ret    
	else if (data == 0x53)
  10049a:	3c 53                	cmp    $0x53,%al
  10049c:	74 04                	je     1004a2 <console_read_digit+0x53>
  10049e:	83 c8 ff             	or     $0xffffffff,%eax
  1004a1:	c3                   	ret    
  1004a2:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  1004a4:	c3                   	ret    

001004a5 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  1004a5:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  1004a9:	a3 2c 7a 10 00       	mov    %eax,0x107a2c

	asm volatile("movl %0,%%esp\n\t"
  1004ae:	83 c0 04             	add    $0x4,%eax
  1004b1:	89 c4                	mov    %eax,%esp
  1004b3:	61                   	popa   
  1004b4:	07                   	pop    %es
  1004b5:	1f                   	pop    %ds
  1004b6:	83 c4 08             	add    $0x8,%esp
  1004b9:	cf                   	iret   
  1004ba:	eb fe                	jmp    1004ba <run+0x15>

001004bc <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  1004bc:	53                   	push   %ebx
  1004bd:	83 ec 0c             	sub    $0xc,%esp
  1004c0:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  1004c4:	6a 44                	push   $0x44
  1004c6:	6a 00                	push   $0x0
  1004c8:	8d 43 04             	lea    0x4(%ebx),%eax
  1004cb:	50                   	push   %eax
  1004cc:	e8 17 01 00 00       	call   1005e8 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  1004d1:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  1004d7:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  1004dd:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  1004e3:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  1004e9:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  1004f0:	83 c4 18             	add    $0x18,%esp
  1004f3:	5b                   	pop    %ebx
  1004f4:	c3                   	ret    
  1004f5:	90                   	nop
  1004f6:	90                   	nop
  1004f7:	90                   	nop

001004f8 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  1004f8:	55                   	push   %ebp
  1004f9:	57                   	push   %edi
  1004fa:	56                   	push   %esi
  1004fb:	53                   	push   %ebx
  1004fc:	83 ec 1c             	sub    $0x1c,%esp
  1004ff:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  100503:	83 f8 03             	cmp    $0x3,%eax
  100506:	7f 04                	jg     10050c <program_loader+0x14>
  100508:	85 c0                	test   %eax,%eax
  10050a:	79 02                	jns    10050e <program_loader+0x16>
  10050c:	eb fe                	jmp    10050c <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  10050e:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  100515:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  10051b:	74 02                	je     10051f <program_loader+0x27>
  10051d:	eb fe                	jmp    10051d <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10051f:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  100522:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100526:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100528:	c1 e5 05             	shl    $0x5,%ebp
  10052b:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  10052e:	eb 3f                	jmp    10056f <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100530:	83 3b 01             	cmpl   $0x1,(%ebx)
  100533:	75 37                	jne    10056c <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100535:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100538:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  10053b:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10053e:	01 c7                	add    %eax,%edi
	memsz += va;
  100540:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  100542:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  100547:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  10054b:	52                   	push   %edx
  10054c:	89 fa                	mov    %edi,%edx
  10054e:	29 c2                	sub    %eax,%edx
  100550:	52                   	push   %edx
  100551:	8b 53 04             	mov    0x4(%ebx),%edx
  100554:	01 f2                	add    %esi,%edx
  100556:	52                   	push   %edx
  100557:	50                   	push   %eax
  100558:	e8 27 00 00 00       	call   100584 <memcpy>
  10055d:	83 c4 10             	add    $0x10,%esp
  100560:	eb 04                	jmp    100566 <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  100562:	c6 07 00             	movb   $0x0,(%edi)
  100565:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  100566:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  10056a:	72 f6                	jb     100562 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  10056c:	83 c3 20             	add    $0x20,%ebx
  10056f:	39 eb                	cmp    %ebp,%ebx
  100571:	72 bd                	jb     100530 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  100573:	8b 56 18             	mov    0x18(%esi),%edx
  100576:	8b 44 24 34          	mov    0x34(%esp),%eax
  10057a:	89 10                	mov    %edx,(%eax)
}
  10057c:	83 c4 1c             	add    $0x1c,%esp
  10057f:	5b                   	pop    %ebx
  100580:	5e                   	pop    %esi
  100581:	5f                   	pop    %edi
  100582:	5d                   	pop    %ebp
  100583:	c3                   	ret    

00100584 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100584:	56                   	push   %esi
  100585:	31 d2                	xor    %edx,%edx
  100587:	53                   	push   %ebx
  100588:	8b 44 24 0c          	mov    0xc(%esp),%eax
  10058c:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100590:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100594:	eb 08                	jmp    10059e <memcpy+0x1a>
		*d++ = *s++;
  100596:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  100599:	4e                   	dec    %esi
  10059a:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  10059d:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  10059e:	85 f6                	test   %esi,%esi
  1005a0:	75 f4                	jne    100596 <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  1005a2:	5b                   	pop    %ebx
  1005a3:	5e                   	pop    %esi
  1005a4:	c3                   	ret    

001005a5 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  1005a5:	57                   	push   %edi
  1005a6:	56                   	push   %esi
  1005a7:	53                   	push   %ebx
  1005a8:	8b 44 24 10          	mov    0x10(%esp),%eax
  1005ac:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1005b0:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  1005b4:	39 c7                	cmp    %eax,%edi
  1005b6:	73 26                	jae    1005de <memmove+0x39>
  1005b8:	8d 34 17             	lea    (%edi,%edx,1),%esi
  1005bb:	39 c6                	cmp    %eax,%esi
  1005bd:	76 1f                	jbe    1005de <memmove+0x39>
		s += n, d += n;
  1005bf:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  1005c2:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  1005c4:	eb 07                	jmp    1005cd <memmove+0x28>
			*--d = *--s;
  1005c6:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  1005c9:	4a                   	dec    %edx
  1005ca:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  1005cd:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  1005ce:	85 d2                	test   %edx,%edx
  1005d0:	75 f4                	jne    1005c6 <memmove+0x21>
  1005d2:	eb 10                	jmp    1005e4 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  1005d4:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  1005d7:	4a                   	dec    %edx
  1005d8:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  1005db:	41                   	inc    %ecx
  1005dc:	eb 02                	jmp    1005e0 <memmove+0x3b>
  1005de:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  1005e0:	85 d2                	test   %edx,%edx
  1005e2:	75 f0                	jne    1005d4 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  1005e4:	5b                   	pop    %ebx
  1005e5:	5e                   	pop    %esi
  1005e6:	5f                   	pop    %edi
  1005e7:	c3                   	ret    

001005e8 <memset>:

void *
memset(void *v, int c, size_t n)
{
  1005e8:	53                   	push   %ebx
  1005e9:	8b 44 24 08          	mov    0x8(%esp),%eax
  1005ed:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  1005f1:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  1005f5:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  1005f7:	eb 04                	jmp    1005fd <memset+0x15>
		*p++ = c;
  1005f9:	88 1a                	mov    %bl,(%edx)
  1005fb:	49                   	dec    %ecx
  1005fc:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  1005fd:	85 c9                	test   %ecx,%ecx
  1005ff:	75 f8                	jne    1005f9 <memset+0x11>
		*p++ = c;
	return v;
}
  100601:	5b                   	pop    %ebx
  100602:	c3                   	ret    

00100603 <strlen>:

size_t
strlen(const char *s)
{
  100603:	8b 54 24 04          	mov    0x4(%esp),%edx
  100607:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100609:	eb 01                	jmp    10060c <strlen+0x9>
		++n;
  10060b:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10060c:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100610:	75 f9                	jne    10060b <strlen+0x8>
		++n;
	return n;
}
  100612:	c3                   	ret    

00100613 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  100613:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  100617:	31 c0                	xor    %eax,%eax
  100619:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10061d:	eb 01                	jmp    100620 <strnlen+0xd>
		++n;
  10061f:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100620:	39 d0                	cmp    %edx,%eax
  100622:	74 06                	je     10062a <strnlen+0x17>
  100624:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100628:	75 f5                	jne    10061f <strnlen+0xc>
		++n;
	return n;
}
  10062a:	c3                   	ret    

0010062b <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  10062b:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  10062c:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100631:	53                   	push   %ebx
  100632:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  100634:	76 05                	jbe    10063b <console_putc+0x10>
  100636:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  10063b:	80 fa 0a             	cmp    $0xa,%dl
  10063e:	75 2c                	jne    10066c <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100640:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  100646:	be 50 00 00 00       	mov    $0x50,%esi
  10064b:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  10064d:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100650:	99                   	cltd   
  100651:	f7 fe                	idiv   %esi
  100653:	89 de                	mov    %ebx,%esi
  100655:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  100657:	eb 07                	jmp    100660 <console_putc+0x35>
			*cursor++ = ' ' | color;
  100659:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  10065c:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  10065d:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100660:	83 f8 50             	cmp    $0x50,%eax
  100663:	75 f4                	jne    100659 <console_putc+0x2e>
  100665:	29 d0                	sub    %edx,%eax
  100667:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  10066a:	eb 0b                	jmp    100677 <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  10066c:	0f b6 d2             	movzbl %dl,%edx
  10066f:	09 ca                	or     %ecx,%edx
  100671:	66 89 13             	mov    %dx,(%ebx)
  100674:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  100677:	5b                   	pop    %ebx
  100678:	5e                   	pop    %esi
  100679:	c3                   	ret    

0010067a <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  10067a:	56                   	push   %esi
  10067b:	53                   	push   %ebx
  10067c:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100680:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100683:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  100687:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  10068c:	75 04                	jne    100692 <fill_numbuf+0x18>
  10068e:	85 d2                	test   %edx,%edx
  100690:	74 10                	je     1006a2 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  100692:	89 d0                	mov    %edx,%eax
  100694:	31 d2                	xor    %edx,%edx
  100696:	f7 f1                	div    %ecx
  100698:	4b                   	dec    %ebx
  100699:	8a 14 16             	mov    (%esi,%edx,1),%dl
  10069c:	88 13                	mov    %dl,(%ebx)
			val /= base;
  10069e:	89 c2                	mov    %eax,%edx
  1006a0:	eb ec                	jmp    10068e <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  1006a2:	89 d8                	mov    %ebx,%eax
  1006a4:	5b                   	pop    %ebx
  1006a5:	5e                   	pop    %esi
  1006a6:	c3                   	ret    

001006a7 <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  1006a7:	55                   	push   %ebp
  1006a8:	57                   	push   %edi
  1006a9:	56                   	push   %esi
  1006aa:	53                   	push   %ebx
  1006ab:	83 ec 38             	sub    $0x38,%esp
  1006ae:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  1006b2:	8b 7c 24 54          	mov    0x54(%esp),%edi
  1006b6:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1006ba:	e9 60 03 00 00       	jmp    100a1f <console_vprintf+0x378>
		if (*format != '%') {
  1006bf:	80 fa 25             	cmp    $0x25,%dl
  1006c2:	74 13                	je     1006d7 <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  1006c4:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1006c8:	0f b6 d2             	movzbl %dl,%edx
  1006cb:	89 f0                	mov    %esi,%eax
  1006cd:	e8 59 ff ff ff       	call   10062b <console_putc>
  1006d2:	e9 45 03 00 00       	jmp    100a1c <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1006d7:	47                   	inc    %edi
  1006d8:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1006df:	00 
  1006e0:	eb 12                	jmp    1006f4 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  1006e2:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  1006e3:	8a 11                	mov    (%ecx),%dl
  1006e5:	84 d2                	test   %dl,%dl
  1006e7:	74 1a                	je     100703 <console_vprintf+0x5c>
  1006e9:	89 e8                	mov    %ebp,%eax
  1006eb:	38 c2                	cmp    %al,%dl
  1006ed:	75 f3                	jne    1006e2 <console_vprintf+0x3b>
  1006ef:	e9 3f 03 00 00       	jmp    100a33 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1006f4:	8a 17                	mov    (%edi),%dl
  1006f6:	84 d2                	test   %dl,%dl
  1006f8:	74 0b                	je     100705 <console_vprintf+0x5e>
  1006fa:	b9 88 0a 10 00       	mov    $0x100a88,%ecx
  1006ff:	89 d5                	mov    %edx,%ebp
  100701:	eb e0                	jmp    1006e3 <console_vprintf+0x3c>
  100703:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  100705:	8d 42 cf             	lea    -0x31(%edx),%eax
  100708:	3c 08                	cmp    $0x8,%al
  10070a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100711:	00 
  100712:	76 13                	jbe    100727 <console_vprintf+0x80>
  100714:	eb 1d                	jmp    100733 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  100716:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  10071b:	0f be c0             	movsbl %al,%eax
  10071e:	47                   	inc    %edi
  10071f:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  100723:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  100727:	8a 07                	mov    (%edi),%al
  100729:	8d 50 d0             	lea    -0x30(%eax),%edx
  10072c:	80 fa 09             	cmp    $0x9,%dl
  10072f:	76 e5                	jbe    100716 <console_vprintf+0x6f>
  100731:	eb 18                	jmp    10074b <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  100733:	80 fa 2a             	cmp    $0x2a,%dl
  100736:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  10073d:	ff 
  10073e:	75 0b                	jne    10074b <console_vprintf+0xa4>
			width = va_arg(val, int);
  100740:	83 c3 04             	add    $0x4,%ebx
			++format;
  100743:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  100744:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100747:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  10074b:	83 cd ff             	or     $0xffffffff,%ebp
  10074e:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100751:	75 37                	jne    10078a <console_vprintf+0xe3>
			++format;
  100753:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  100754:	31 ed                	xor    %ebp,%ebp
  100756:	8a 07                	mov    (%edi),%al
  100758:	8d 50 d0             	lea    -0x30(%eax),%edx
  10075b:	80 fa 09             	cmp    $0x9,%dl
  10075e:	76 0d                	jbe    10076d <console_vprintf+0xc6>
  100760:	eb 17                	jmp    100779 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  100762:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100765:	0f be c0             	movsbl %al,%eax
  100768:	47                   	inc    %edi
  100769:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  10076d:	8a 07                	mov    (%edi),%al
  10076f:	8d 50 d0             	lea    -0x30(%eax),%edx
  100772:	80 fa 09             	cmp    $0x9,%dl
  100775:	76 eb                	jbe    100762 <console_vprintf+0xbb>
  100777:	eb 11                	jmp    10078a <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  100779:	3c 2a                	cmp    $0x2a,%al
  10077b:	75 0b                	jne    100788 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  10077d:	83 c3 04             	add    $0x4,%ebx
				++format;
  100780:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100781:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100784:	85 ed                	test   %ebp,%ebp
  100786:	79 02                	jns    10078a <console_vprintf+0xe3>
  100788:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  10078a:	8a 07                	mov    (%edi),%al
  10078c:	3c 64                	cmp    $0x64,%al
  10078e:	74 34                	je     1007c4 <console_vprintf+0x11d>
  100790:	7f 1d                	jg     1007af <console_vprintf+0x108>
  100792:	3c 58                	cmp    $0x58,%al
  100794:	0f 84 a2 00 00 00    	je     10083c <console_vprintf+0x195>
  10079a:	3c 63                	cmp    $0x63,%al
  10079c:	0f 84 bf 00 00 00    	je     100861 <console_vprintf+0x1ba>
  1007a2:	3c 43                	cmp    $0x43,%al
  1007a4:	0f 85 d0 00 00 00    	jne    10087a <console_vprintf+0x1d3>
  1007aa:	e9 a3 00 00 00       	jmp    100852 <console_vprintf+0x1ab>
  1007af:	3c 75                	cmp    $0x75,%al
  1007b1:	74 4d                	je     100800 <console_vprintf+0x159>
  1007b3:	3c 78                	cmp    $0x78,%al
  1007b5:	74 5c                	je     100813 <console_vprintf+0x16c>
  1007b7:	3c 73                	cmp    $0x73,%al
  1007b9:	0f 85 bb 00 00 00    	jne    10087a <console_vprintf+0x1d3>
  1007bf:	e9 86 00 00 00       	jmp    10084a <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  1007c4:	83 c3 04             	add    $0x4,%ebx
  1007c7:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  1007ca:	89 d1                	mov    %edx,%ecx
  1007cc:	c1 f9 1f             	sar    $0x1f,%ecx
  1007cf:	89 0c 24             	mov    %ecx,(%esp)
  1007d2:	31 ca                	xor    %ecx,%edx
  1007d4:	55                   	push   %ebp
  1007d5:	29 ca                	sub    %ecx,%edx
  1007d7:	68 90 0a 10 00       	push   $0x100a90
  1007dc:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1007e1:	8d 44 24 40          	lea    0x40(%esp),%eax
  1007e5:	e8 90 fe ff ff       	call   10067a <fill_numbuf>
  1007ea:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  1007ee:	58                   	pop    %eax
  1007ef:	5a                   	pop    %edx
  1007f0:	ba 01 00 00 00       	mov    $0x1,%edx
  1007f5:	8b 04 24             	mov    (%esp),%eax
  1007f8:	83 e0 01             	and    $0x1,%eax
  1007fb:	e9 a5 00 00 00       	jmp    1008a5 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100800:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  100803:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100808:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10080b:	55                   	push   %ebp
  10080c:	68 90 0a 10 00       	push   $0x100a90
  100811:	eb 11                	jmp    100824 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  100813:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  100816:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100819:	55                   	push   %ebp
  10081a:	68 a4 0a 10 00       	push   $0x100aa4
  10081f:	b9 10 00 00 00       	mov    $0x10,%ecx
  100824:	8d 44 24 40          	lea    0x40(%esp),%eax
  100828:	e8 4d fe ff ff       	call   10067a <fill_numbuf>
  10082d:	ba 01 00 00 00       	mov    $0x1,%edx
  100832:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100836:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100838:	59                   	pop    %ecx
  100839:	59                   	pop    %ecx
  10083a:	eb 69                	jmp    1008a5 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  10083c:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  10083f:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100842:	55                   	push   %ebp
  100843:	68 90 0a 10 00       	push   $0x100a90
  100848:	eb d5                	jmp    10081f <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  10084a:	83 c3 04             	add    $0x4,%ebx
  10084d:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100850:	eb 40                	jmp    100892 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  100852:	83 c3 04             	add    $0x4,%ebx
  100855:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100858:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  10085c:	e9 bd 01 00 00       	jmp    100a1e <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100861:	83 c3 04             	add    $0x4,%ebx
  100864:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  100867:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  10086b:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100870:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100874:	88 44 24 24          	mov    %al,0x24(%esp)
  100878:	eb 27                	jmp    1008a1 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  10087a:	84 c0                	test   %al,%al
  10087c:	75 02                	jne    100880 <console_vprintf+0x1d9>
  10087e:	b0 25                	mov    $0x25,%al
  100880:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100884:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100889:	80 3f 00             	cmpb   $0x0,(%edi)
  10088c:	74 0a                	je     100898 <console_vprintf+0x1f1>
  10088e:	8d 44 24 24          	lea    0x24(%esp),%eax
  100892:	89 44 24 04          	mov    %eax,0x4(%esp)
  100896:	eb 09                	jmp    1008a1 <console_vprintf+0x1fa>
				format--;
  100898:	8d 54 24 24          	lea    0x24(%esp),%edx
  10089c:	4f                   	dec    %edi
  10089d:	89 54 24 04          	mov    %edx,0x4(%esp)
  1008a1:	31 d2                	xor    %edx,%edx
  1008a3:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1008a5:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  1008a7:	83 fd ff             	cmp    $0xffffffff,%ebp
  1008aa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1008b1:	74 1f                	je     1008d2 <console_vprintf+0x22b>
  1008b3:	89 04 24             	mov    %eax,(%esp)
  1008b6:	eb 01                	jmp    1008b9 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  1008b8:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1008b9:	39 e9                	cmp    %ebp,%ecx
  1008bb:	74 0a                	je     1008c7 <console_vprintf+0x220>
  1008bd:	8b 44 24 04          	mov    0x4(%esp),%eax
  1008c1:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  1008c5:	75 f1                	jne    1008b8 <console_vprintf+0x211>
  1008c7:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1008ca:	89 0c 24             	mov    %ecx,(%esp)
  1008cd:	eb 1f                	jmp    1008ee <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  1008cf:	42                   	inc    %edx
  1008d0:	eb 09                	jmp    1008db <console_vprintf+0x234>
  1008d2:	89 d1                	mov    %edx,%ecx
  1008d4:	8b 14 24             	mov    (%esp),%edx
  1008d7:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1008db:	8b 44 24 04          	mov    0x4(%esp),%eax
  1008df:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  1008e3:	75 ea                	jne    1008cf <console_vprintf+0x228>
  1008e5:	8b 44 24 08          	mov    0x8(%esp),%eax
  1008e9:	89 14 24             	mov    %edx,(%esp)
  1008ec:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  1008ee:	85 c0                	test   %eax,%eax
  1008f0:	74 0c                	je     1008fe <console_vprintf+0x257>
  1008f2:	84 d2                	test   %dl,%dl
  1008f4:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  1008fb:	00 
  1008fc:	75 24                	jne    100922 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  1008fe:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100903:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  10090a:	00 
  10090b:	75 15                	jne    100922 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  10090d:	8b 44 24 14          	mov    0x14(%esp),%eax
  100911:	83 e0 08             	and    $0x8,%eax
  100914:	83 f8 01             	cmp    $0x1,%eax
  100917:	19 c9                	sbb    %ecx,%ecx
  100919:	f7 d1                	not    %ecx
  10091b:	83 e1 20             	and    $0x20,%ecx
  10091e:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100922:	3b 2c 24             	cmp    (%esp),%ebp
  100925:	7e 0d                	jle    100934 <console_vprintf+0x28d>
  100927:	84 d2                	test   %dl,%dl
  100929:	74 40                	je     10096b <console_vprintf+0x2c4>
			zeros = precision - len;
  10092b:	2b 2c 24             	sub    (%esp),%ebp
  10092e:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100932:	eb 3f                	jmp    100973 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100934:	84 d2                	test   %dl,%dl
  100936:	74 33                	je     10096b <console_vprintf+0x2c4>
  100938:	8b 44 24 14          	mov    0x14(%esp),%eax
  10093c:	83 e0 06             	and    $0x6,%eax
  10093f:	83 f8 02             	cmp    $0x2,%eax
  100942:	75 27                	jne    10096b <console_vprintf+0x2c4>
  100944:	45                   	inc    %ebp
  100945:	75 24                	jne    10096b <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100947:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100949:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  10094c:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100951:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100954:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100957:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  10095b:	7d 0e                	jge    10096b <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  10095d:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100961:	29 ca                	sub    %ecx,%edx
  100963:	29 c2                	sub    %eax,%edx
  100965:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100969:	eb 08                	jmp    100973 <console_vprintf+0x2cc>
  10096b:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100972:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100973:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100977:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100979:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  10097d:	2b 2c 24             	sub    (%esp),%ebp
  100980:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100985:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100988:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  10098b:	29 c5                	sub    %eax,%ebp
  10098d:	89 f0                	mov    %esi,%eax
  10098f:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100993:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100997:	eb 0f                	jmp    1009a8 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100999:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  10099d:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009a2:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  1009a3:	e8 83 fc ff ff       	call   10062b <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009a8:	85 ed                	test   %ebp,%ebp
  1009aa:	7e 07                	jle    1009b3 <console_vprintf+0x30c>
  1009ac:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  1009b1:	74 e6                	je     100999 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  1009b3:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009b8:	89 c6                	mov    %eax,%esi
  1009ba:	74 23                	je     1009df <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  1009bc:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  1009c1:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009c5:	e8 61 fc ff ff       	call   10062b <console_putc>
  1009ca:	89 c6                	mov    %eax,%esi
  1009cc:	eb 11                	jmp    1009df <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  1009ce:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009d2:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  1009d7:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  1009d8:	e8 4e fc ff ff       	call   10062b <console_putc>
  1009dd:	eb 06                	jmp    1009e5 <console_vprintf+0x33e>
  1009df:	89 f0                	mov    %esi,%eax
  1009e1:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  1009e5:	85 f6                	test   %esi,%esi
  1009e7:	7f e5                	jg     1009ce <console_vprintf+0x327>
  1009e9:	8b 34 24             	mov    (%esp),%esi
  1009ec:	eb 15                	jmp    100a03 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  1009ee:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  1009f2:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  1009f3:	0f b6 11             	movzbl (%ecx),%edx
  1009f6:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009fa:	e8 2c fc ff ff       	call   10062b <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  1009ff:	ff 44 24 04          	incl   0x4(%esp)
  100a03:	85 f6                	test   %esi,%esi
  100a05:	7f e7                	jg     1009ee <console_vprintf+0x347>
  100a07:	eb 0f                	jmp    100a18 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100a09:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a0d:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a12:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a13:	e8 13 fc ff ff       	call   10062b <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a18:	85 ed                	test   %ebp,%ebp
  100a1a:	7f ed                	jg     100a09 <console_vprintf+0x362>
  100a1c:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100a1e:	47                   	inc    %edi
  100a1f:	8a 17                	mov    (%edi),%dl
  100a21:	84 d2                	test   %dl,%dl
  100a23:	0f 85 96 fc ff ff    	jne    1006bf <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100a29:	83 c4 38             	add    $0x38,%esp
  100a2c:	89 f0                	mov    %esi,%eax
  100a2e:	5b                   	pop    %ebx
  100a2f:	5e                   	pop    %esi
  100a30:	5f                   	pop    %edi
  100a31:	5d                   	pop    %ebp
  100a32:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a33:	81 e9 88 0a 10 00    	sub    $0x100a88,%ecx
  100a39:	b8 01 00 00 00       	mov    $0x1,%eax
  100a3e:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100a40:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a41:	09 44 24 14          	or     %eax,0x14(%esp)
  100a45:	e9 aa fc ff ff       	jmp    1006f4 <console_vprintf+0x4d>

00100a4a <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100a4a:	8d 44 24 10          	lea    0x10(%esp),%eax
  100a4e:	50                   	push   %eax
  100a4f:	ff 74 24 10          	pushl  0x10(%esp)
  100a53:	ff 74 24 10          	pushl  0x10(%esp)
  100a57:	ff 74 24 10          	pushl  0x10(%esp)
  100a5b:	e8 47 fc ff ff       	call   1006a7 <console_vprintf>
  100a60:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100a63:	c3                   	ret    
