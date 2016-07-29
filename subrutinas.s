@@------------------------------------------------------
@@Carlos Calderon 15219 
@@ Ejercicio 1 
@@ Subrutinas: archivo que contiene las subrutinas para leer
@@ valores y calcular maximo
@@------------------------------------------------------
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
@@ Subrutina maximo
maximo:
	push {lr} 
	@@ Limpiar registros
	and r1,#0
	and r2,#0
	and r3,#0	
	@@ Ciclo que calcula el mayor de los numeros
	ciclo:
	add r3,r3,#1  @@ contador
	ldr r2,[r0],#4 @@ leer en r2 el vector
	cmp r2,r1	@@ Comparar 
	movge r1,r2 @@Lo leido se va a r1
	cmp r3,#10	
	bne ciclo
	pop {pc}
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
		mov r1, r1
		cmp r0,#0
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
