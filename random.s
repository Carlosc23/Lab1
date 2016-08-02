/* ***************************************************************** 
   random.s
   Programa que...
   Autores: 
   Carlos Calderon ,Carne: 15219
   Gabriel Brolo ,Carne: 15105
   Laboratorio1
   ***************************************************************** */

.data
.align 2

formato:			.asciz "Su numero es: %f\n"
formatom:			.asciz "El numero es: %d\n"
vec:				.word 0,0,0,0,0

/*--Seccion de codigo*/
.text

.align 2
.global lfsr,minimo,maximo,average,norm,imprimir, convertToFloat

/* Subrutina para generar numeros aleatorios*/
lfsr:
	mov r9,lr /* guarda valor de lr en r9 */
	mov r6,#0 /* contador:		inicializar en 0 */
	mov r7,r2 /* guardar valor original de semilla */
	ldr r8,= vector

	/* genera numeros random y los aloja en vector */
	loop:
		/*cmp r6,#32768  compara si ya realizo las iteraciones necesarias */
		cmp r6,r1
		beq retorno
		
		movs r2,r2,lsr #1 /* shift a la derecha */
		eorcc r2,r2,#1<<2 /* xor con bit 2 */
		tst r2,#1
		eorne r2,r2,#1<<22 /* xor con bit 22 */


		str r2,[r8]
		

		add r8,#4		

		add r7,#1 /* aumentar en 1 el valor original de semilla para generar otro random */
		mov r2,r7 /* mover ese valor aumentado a r2 */
		add r6,#1 /* incrementar contador en 1 */
		b loop

	retorno:
		mov pc, r9

convertToFloat:
	mov r9, lr

	mov r6,#0 /*contador*/
	mov r8,#0

	loopVer:
		cmp r6,r2
		beq retornar
		ldr r1,=vector
		add r1,r8
		vldr s14,[r1]
		vcvt.f64.u32 d5,s14
		vcvt.f32.u32 s15,s14
		vstr s15,[r1]
		
		add r6,r6,#1
		add r8,r8,#4

		b loopVer

	retornar:
		mov pc, r9

/*Subrutina minimo */
minimo:
	push {lr} 
	/*Limpiar registros*/
	and r2,#0
	and r3,#0
	/* Ciclo que calcula el menor de los numeros*/	
	vldr s2,[r0]
	ciclo:
	cmp r3,r1	
	beq fin
	add r3,r3,#1  
	vldr s8,[r0] 
	add r0,r0,#4
	VCMP.F32 S8,S2
	VMRS APSR_nzcv, FPSCR
	ble m
	bgt ciclo
	fin:
	VSTR S2,[R0]
	pop {pc}
	m:
	VMOV S2,S8
	b ciclo
/*************************************************************************************** */
/*Subrutina maximo */
maximo:
	push {lr} 
	/*Limpiar registros*/
	and r2,#0
	and r3,#0
	/* Ciclo que calcula el mayor de los numeros*/		
	vldr s2,[r0]
	ciclo2:
	cmp r3,r1	
	beq fin2
	add r3,r3,#1  
	vldr s8,[r0] 
	add r0,r0,#4
	VCMP.F32 S8,S2
	VMRS APSR_nzcv, FPSCR
	bge m2
	blt ciclo2
	fin2:
	VSTR S2,[R0]
	pop {pc}
	m2:
	VMOV S2,S8
	b ciclo2	
/*************************************************************************************** */
/*Subrutina average */
average:
push {lr} 
	/*Limpiar registros*/
	and r2,#0
	and r3,#0
	LDR R2, addr_value5		
	VLDR S22, [R2]	
	/* Ciclo para calcular el promedio*/
	ciclo3:
	cmp r3,r1	
	beq fin3
	add r3,r3,#1  
	vldr s8,[r0] 
	add r0,r0,#4
	VADD.F32 S0,S0,S8
	b ciclo3
	fin3:
	VDIV.F32 S6,S0,S22	
	VSTR S6,[R0]
	pop {pc}
/*************************************************************************************** */
/* Subrutina normalizar */
norm:
push {lr}
	/* Limpiar registros*/
	and r2,#0
	mov r4,#0
	ldr r8,=vector
	vldr s4,[r3]
	/* Ciclo que normaliza el vector*/	
	ciclo4:
	cmp r4,r1	
	beq fin4
	add r4,r4,#1
	vldr s8,[r8] 
	VDIV.F32 S6,S8,S4
	VSTR S6,[R8]
	add r8,r8,#4
	
	b ciclo4
	
	fin4:
	pop {pc}

/* ***************************************************************** */
/* Subrutina imprimir */
imprimir:
	push {lr}
	/*Limpiar registros*/
	mov r6,#0
	mov r8,#0
	/*Ciclo para imprimir*/
	ciclo5:
		/*cmp r6,#32768*/
		cmp r6,r1
		beq retornof
		ldr r0,=vector
		add r0,r8
		vldr s14,[r0]
		vcvt.f64.f32 d5,s14
		ldr r0,=formato4
		vmov r2,r3,d5
		push {r1}
		bl printf
		pop {r1}
		add r8,#4
		add r6,#1
		b ciclo5
	retornof:	
	pop {pc}
	
/* Variables*/
addr_value5:
	.word value5
	.data
value5:	.float 5.0
string:	.asciz "Floating value is: %f\n"
formato4:			.asciz "Su decimal es: %f\n"
