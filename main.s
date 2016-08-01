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
formato3:			.asciz "Su numero aleatorio es: %d\n"
formato4:			.asciz "Su decimal es: %f\n"
formato5:			.asciz "Su maximo es: %f\n"
/*vector:				.space 262144*/
vector:				.space 5
/***************************************************************** */

/*--Seccion de codigo*/
.text

.align 2
.global main
main:
	/*stmfd   sp!, {lr}*/

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
	/*mov r1,#32768*/
	mov r1,#5
	ldr r2,= semilla
	ldr r2,[r2]
	bl lfsr

	ldr r8,=vector
		mov r6,#0
		loops:
			/*cmp r6,#32768*/
			cmp r6,#5
			beq continue

			ldr r1,[r8]
			ldr r0,=formato3
			bl printf
			add r8,#4
			add r6,#1
			b loops
	
continue:
	bl convertToFloat

	mov r6,#0
	mov r8,#0
	loopr:
		/*cmp r6,#32768*/
		cmp r6,#5
		beq continue2

		ldr r1,=vector
		add r1,r8
		vldr s14,[r1]
		vcvt.f64.f32 d5,s14

		ldr r0,=formato4
		vmov r2,r3,d5
		bl printf
		add r8,#4
		add r6,#1
		b loopr

continue2:
	ldr r0,=vector
	bl maximo
	
	mov r3,r0

	vldr s14,[r0]
	vcvt.f64.f32 d5,s14

	ldr r0,=formato5
	vmov r2,r3,d5
	bl printf

	/*bl norm*/

end:
	/*mov r3,#0*/
	/*mov r0,r3*/
	/*ldmfd  sp!, {lr}*/
	/*bx lr*/
	mov r7,#1
	swi 0
