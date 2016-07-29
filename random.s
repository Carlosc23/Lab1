/* ***************************************************************** 
   random.s
   Programa que...
   Autores: 
   Carlos Calderon ,Carne: 15219
   Gabriel Brolo ,Carne: 15105
   Laboratorio1
   ***************************************************************** */

/*--Seccion de codigo*/
.text

.align 2
.global lfsr

lfsr:
	/*R4:	start_state*/
	mov r4,r2
	/*R5:	lfsr*/
	mov r5,r4

	/*R6:	lsb*/
	and r6,r5,#1
	lsr r5,#1

	mov pc, lr