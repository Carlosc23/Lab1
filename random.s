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

/*--Seccion de codigo*/
.text

.align 2
.global lfsr

lfsr:
	mov r9,lr /* guarda valor de lr en r9 */
	mov r6,#0 /* contador:		inicializar en 0 */
	mov r7,r2 /* guardar valor original de semilla */

	/* genera numeros random y los aloja en vector */
	loop:
		cmp r6,#5 /* compara si ya realizo las iteraciones necesarias */
		beq retorno
		
		movs r2,r2,lsr #1 /* shift a la derecha */
		eorcc r2,r2,#1<<2 /* xor con bit 2 */
		tst r2,#1
		eorne r2,r2,#1<<22 /* xor con bit 22 */

		str r2,[r0],#4

		/* Imprime el valor que se acaba de generar */
		mov r1,r2 
		push {r0}
		ldr r0,=formato
		bl printf
		pop {r0}

		add r7,#1 /* aumentar en 1 el valor original de semilla para generar otro random */
		mov r2,r7 /* mover ese valor aumentado a r2 */
		add r6,#1 /* incrementar contador en 1 */
		b loop

	retorno:
		mov pc, r9
