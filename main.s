/* ***************************************************************** 
   main.s
   Programa que...
   Autores: 
   Carlos Calderon ,Carne: 15219
   Gabriel Brolo ,Carne: 15105
   Laboratorio1
   ***************************************************************** */

.align 2
@@ Variables de inicio 
***************************************************************** */
Bienvenida:.asciz "¡Bienvenid@ al programa! " 
Instrucciones: .asciz "Este programa calcula el numero entero mayor de 10 que son ingresados por el usuario"
***************************************************************** */--
@@ Codigo de assembler: se coloca en la seccion .text
	.text
	.align		2
	.global		main
	.type		main,%function
 /* ***************************************************************** ***************************************************************** */
@@ main
main:
	@@ Grabar registro de enlace en la pila
	stmfd	sp!, {lr}
	ldr r0,=Bienvenida @@ Mensaje de inicio
	bl puts
	ldr r0,=Instrucciones @@ Instrucciones
	bl puts
	ldr r0, =vector
	bl leer	@@Subrutina para ingreso
	
	fin:
	mov r3,#0
	mov r0,#0
	ldmfd sp!,{lr}
	bx lr