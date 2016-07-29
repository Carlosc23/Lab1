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
vector:				.space 5
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
	mov r1,#5
	ldr r2,= semilla
	ldr r2,[r2]
	bl lfsr

	/* Imprimir vector */
	mov r6,#0
	loop2:
		cmp r6,#5
		beq end
		ldr r1, [r0, #4]
		push {r0}
		bl printf
		pop {r0}
		add r6,#1
		b loop2
	

end:
	mov r3,#0
	mov r0,r3
	ldmfd  sp!, {lr}
	bx lr
