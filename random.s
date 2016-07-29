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
@@ Variables de inicio 
@@-----------------------------------------------------------------------------------------------------
mensaje_ingreso: 	.asciz "Ingrese un numero: "  @@Mensaje para que ingresen los numeros uno por uno 
entrada:			.asciz "%d"@@formato de numero decimal para la entrada
.text
.align 2
.global maximo, leer
@-------------------------------------------------------------------------------------------
@@ Subrutina leer
leer:
	push {lr}
	mov r2, #0
	mov r1, r0
	@@ Ciclo para ir ingresando 10 numeros
	ciclo2: 
		push {r0-r3}
		ldr r0,=mensaje_ingreso @@se muestra mensaje para empezar a ingresar numeros
		bl puts @@se imprime el mensaje 
		pop {r0-r3}
		push {r0-r3}
		ldr r0, =entrada
		bl scanf
@@ Ciclo para cambiar de posicion el vector y hacer cuentas
	seguir:
		pop {r0-r3}
		add r2, r2, #1
		add r1, r1, #4
		cmp r2, #10
		bne ciclo2  
	pop {pc}		
@-------------------------------------------------------------------------------------------
