@@------------------------------------------------------
@@Carlos Calderon 15219 
@@ Ejercicio 1 
@@ Main: archivo principal que llama subrutinas para calcular el
@@maximo de 10 numeros
@@------------------------------------------------------
.data
.align 2
@@ Variables de inicio 
@@-----------------------------------------------------------------------------------------------------
Bienvenida:.asciz "¡Bienvenid@ al programa! " 
Instrucciones: .asciz "Este programa calcula el numero entero mayor de 10 que son ingresados por el usuario"
vector:				.word 0,0,0,0,0,0,0,0,0,0 @@vector de ingreso
FormatoD:			.asciz "El valor maximo es: %d  \n"
@@-----------------------------------------------------------------------------------------------------
@@ Codigo de assembler: se coloca en la seccion .text
	.text
	.align		2
	.global		main
	.type		main,%function
@@-----------------------------------------------------------------------------------------------------
@@ main
main:
	@@ Grabar registro de enlace en la pila
	stmfd	sp!, {lr}
	@@ Mensaje de inicio
	ldr r0,=Bienvenida
	bl puts
	@@ Instrucciones
	ldr r0,=Instrucciones
	bl puts
	@@Subrutina para ingreso
	ldr r0, =vector
	bl leer
	@@Subrutina para calcular maximo
	ldr r0, =vector
	bl maximo @@ carga resultado y lo muestra	
	@@ Despliegue de resultados
	mov r1, r1
	ldr r0, =FormatoD
	bl printf
	b fin
	
	fin:
	mov r3,#0
	mov r0,#0
	ldmfd sp!,{lr}
	bx lr