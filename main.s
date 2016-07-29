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
/***************************************************************** */
Bienvenida:			.asciz "¡Bienvenid@ al programa! \n" 
Instrucciones: 		.asciz "Este programa genera numeros aleatorios y le muestra maximos y minimos. \nIngrese la semilla\n"
intEntrada:			.word 0
formato:			.asciz "%d"
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

	ldr r8,= intEntrada
	ldr r0,= formato
	mov r1,r8
	bl scanf
	

end:
	mov r3,#0
	mov r0,r3
	ldmfd  sp!, {lr}
	bx lr
