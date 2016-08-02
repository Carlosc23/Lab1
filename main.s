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
nor:				.asciz "Su vector normalizado es:"
semilla:			.word 0
formato:			.asciz "%d"
formato2:			.asciz "Su semilla es: %d\n"
formato3:			.asciz "Su numero aleatorio es: %d\n"
formato4:			.asciz "Su decimal es: %f\n"
formato5:			.asciz "Su maximo es: %f\n"
formato6:			.asciz "Su minimo es: %f\n"
formato7:			.asciz "Su promedio del vector normalizado es: %f\n"
/*vector:				.space 262144*/
vector:				.space 5
/***************************************************************** */

/*--Seccion de codigo*/
.text

.align 2
.global main
main:
	/*stmfd   sp!, {lr}*/
	/* Dar bienvenida e instrucciones al usuario*/
	ldr r0,= Bienvenida
	bl printf
	ldr r0,= Instrucciones
	bl printf
	/*Ingreso de datos*/
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

/* Llamar subrutina para convertir a punto flotante*/
	/*mov r2,#32768*/
	mov r2,#5
	bl convertToFloat

/* Llamar a subrutina para encontrar el minimo del vector*/
	ldr r0,=vector
	/*mov r1,#32768*/
	mov r1,#5
	bl minimo
/* Imprimir el minimo*/	
	mov r3,r0

	vldr s14,[r3]
	vcvt.f64.f32 d5,s14
	push {r0-r3}
	ldr r0,=formato6
	vmov r2,r3,d5
	bl printf
	pop {r0-r3}
	
/* Llamar a subrutina para encontrar el maximo del vector*/
	ldr r0,=vector
	/*mov r1,#32768*/
	mov r1,#5
	bl maximo
/* Imprimir el maximo*/	
	mov r3,r0

	vldr s14,[r3]
	vcvt.f64.f32 d5,s14
	push {r0-r3}
	ldr r0,=formato5
	vmov r2,r3,d5
	bl printf
	pop {r0-r3}
	

/*Llamar a subrutina normalizar para el vector*/ 	
	mov r3,r0
	bl norm
/* Llamar a subrutina para encontrar el promedio del vector*/
	ldr r0,=vector
	/*mov r1,#32768*/
	mov r1,#5
	bl average
/* Imprimir el promedio*/	
	mov r3,r0

	vldr s14,[r3]
	vcvt.f64.f32 d5,s14
	push {r0-r3}
	ldr r0,=formato7
	vmov r2,r3,d5
	bl printf
	pop {r0-r3}
	
/* Llamar a subrutina imprimir*/
	/*mov r1,#32768*/
	ldr r0,=nor
	bl puts
	mov r1,#5
	ldr r0,=vector
	bl imprimir

/* Finalizar el programa*/
end:
		
	mov r7,#1
	swi 0