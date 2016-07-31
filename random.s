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

formato:			.asciz "Su numero es: %d\n"
vec:				.word 0,0,0,0,0

/*--Seccion de codigo*/
.text

.align 2
.global lfsr,minimo,maximo,average,norm,imprimir

lfsr:
	mov r9,lr /* guarda valor de lr en r9 */
	mov r6,#0 /* contador:		inicializar en 0 */
	mov r7,r2 /* guardar valor original de semilla */
	ldr r8,= vector

	/* genera numeros random y los aloja en vector */
	loop:
		cmp r6,#32768 /* compara si ya realizo las iteraciones necesarias */
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
/*Subrutina minimo */
minimo:
	push {lr} 
	@@ Limpiar registros
	and r2,#0
	and r3,#0
	@@mov r4,#0
	@@ Ciclo que calcula el mayor de los numeros	
	vldr s2,[r0]
	ciclo:
	cmp r3,#5	
	beq fin
	add r3,r3,#1  @@ contador
	vldr s8,[r0] @@ leer en r2 el vector
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
	@@ Limpiar registros
	and r2,#0
	and r3,#0
	@@mov r4,#0
	@@ Ciclo que calcula el mayor de los numeros	
	vldr s2,[r0]
	ciclo2:
	cmp r3,#5	
	beq fin2
	add r3,r3,#1  @@ contador
	vldr s8,[r0] @@ leer en r2 el vector
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
	@@ Limpiar registros
	and r2,#0
	and r3,#0
	LDR R1, addr_value5		
	VLDR S22, [R1]	
	ciclo3:
	cmp r3,#5	
	beq fin3
	add r3,r3,#1  @@ contador
	vldr s8,[r0] @@ leer en r2 el vector
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
	and r2,#0
	mov r4,#0
	ldr r8,=vector
	vldr s4,[r3]
	
	ciclo4:
	cmp r4,#5	
	beq fin4
	add r4,r4,#1
	vldr s8,[r8] @@ leer en r2 el vector
	VDIV.F32 S6,S8,S4
	VSTR S6,[R8]
	add r0,r0,#4
	
	b ciclo4
	
	fin4:
	pop {pc}

/* ***************************************************************** */
/* Subrutina imprimir */
imprimir:
	push {lr}
	and r2,#0
	and r3,#0
	mov r4,#0
	ldr r1,=vector
	ciclo5:
	cmp r4,#5
	beq ciclo5
	ldr r1,[r1]
	vmov s15,r1
	vcvt.f64.f32 d5,s15
	push {r0}
	vmov r2,r3,d5
	ldr r0,=string
	bl printf
	pop {r0}
	add r1,r1,#4
	b ciclo5
	fin5:
	pop {pc}
/* Variables*/
addr_value5:
	.word value5
	.data
value5:	.float 5.0
string:	.asciz "Floating value is: %f\n"