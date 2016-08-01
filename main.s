<<<<<<< HEAD
/* ***************************************************************** 
   main.s
   Programa que...
   Autores: 
   Carlos Calderon ,Carne: 15219
   Gabriel Brolo ,Carne: 15105
   Laboratorio1
   ***************************************************************** */

/*--Seccion de datos*/
.data
.align 2
.global vector
/***************************************************************** */
Bienvenida:			.asciz "¡Bienvenid@ al programa! \n" 
Instrucciones: 		.asciz "Este programa genera numeros aleatorios y le muestra maximos y minimos. \nIngrese la semilla\n"
semilla:			.word 0
formato:			.asciz "%d"
formato2:			.asciz "Su semilla es: %d\n"
formato3:			.asciz "Su valor es: %d\n"
vector:				.space 262144
/***************************************************************** */

/*--Seccion de codigo*/
.text

.align 2
.global main
main:
	stmfd   sp!, {lr}

	ldr r0,= Bienvenida
	bl printf
	ldr r0,= Instrucciones
	bl printf

	ldr r8,= semilla
	ldr r0,= formato
	mov r1,r8
	bl scanf

	ldr r2,= semilla
	ldr r0,= formato2
	ldr r1,[r2]
	bl printf

	/* Mandar datos a lfsr */
	ldr r0,= vector
	mov r1,#32768
	ldr r2,= semilla
	ldr r2,[r2]
	bl lfsr

	ldr r8,=vector
		mov r6,#0
		loops:
			cmp r6,#32768
			beq end

			ldr r1,[r8]
			ldr r0,=formato3
			bl printf
			add r8,#4
			add r6,#1
			b loops
	
	

end:
	mov r3,#0
	mov r0,r3
	ldmfd  sp!, {lr}
	bx lr
=======
/* ***************************************************************** 
   main.s
   Programa que...
   Autores: 
   Carlos Calderon ,Carne: 15219
   Gabriel Brolo ,Carne: 15105
   Laboratorio1
   ***************************************************************** */

/*--Seccion de datos*/
.data
.align 2
.global vector
/***************************************************************** */
Bienvenida:			.asciz "¡Bienvenid@ al programa! \n" 
Instrucciones: 		.asciz "Este programa genera numeros aleatorios y le muestra maximos y minimos. \nIngrese la semilla\n"
semilla:			.word 0
formato:			.asciz "%d"
formato2:			.asciz "Su semilla es: %d\n"
formato3:			.asciz "Su valor es: %d\n"
vector:				.space 262144
/***************************************************************** */

/*--Seccion de codigo*/
.text

.align 2
.global main
main:
	stmfd   sp!, {lr}

	ldr r0,= Bienvenida
	bl printf
	ldr r0,= Instrucciones
	bl printf

	ldr r8,= semilla
	ldr r0,= formato
	mov r1,r8
	bl scanf

	ldr r2,= semilla
	ldr r0,= formato2
	ldr r1,[r2]
	bl printf

	/* Mandar datos a lfsr */
	ldr r0,= vector
	mov r1,#32768
	ldr r2,= semilla
	ldr r2,[r2]
	bl lfsr

	ldr r8,=vector
		mov r6,#0
		loops:
			cmp r6,#32768
			beq end

			ldr r1,[r8]
			ldr r0,=formato3
			bl printf
			add r8,#4
			add r6,#1
			b loops
	
	

end:
	mov r3,#0
	mov r0,r3
	ldmfd  sp!, {lr}
	bx lr
>>>>>>> 1ac5b3d68e99aec7c1febb7eed5e09047f106db6
