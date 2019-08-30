# maior e menor valor de um vetor
.data
space: .asciiz " "
X: .word 1, 2, 3, 4, 5	 			 	#vetor de 5 elementos
N: .word 5						#número de elementos

.text
main:   la $a0, X       #$a0=endereco de carregamento do vetor X
    	lw $a1, N       #$a1=5  elementos numericos
    	
    	li $t2, 0
    	li $t3, 100	
    	
    	jal readArray  #chamada readArray
    	li $v0, 10      #programa de saida
    	syscall 
    	
    	
readArray:
    li $t0, 0       		#contador = 0 
    li $t1, 0       		#localizacao do vetor= 0
    
loop:    bge $t0, $a1, final 	#if  $t0 >= $a1 goto final
    lw $a0, X($t1) 		#$a0 = X(i)
    
    blt $a0, $t3, new_min	#if X(i) < min
    j check_max
    new_min: move $t3, $a0		#min = X(i)
    j update_counter
    
    check_max:
    bgt $a0, $t2, new_max	#if X(i) > max
    j update_counter
    
    new_max: move $t2, $a0		#max = X(i)
    
    update_counter:
    addi $t1, $t1, 4    	#A cada 4 bytes existe um inteiro no array
    addi $t0, $t0, 1    	#contador ++
    b loop       		#goto loop
final:  
	li $v0, 1		#imprimi int
	move $a0, $t2		#carregar o max a ser impresso
	syscall			#executar a impressao

	la $a0, space   	#carrega um espaco:  " "
    	li $v0, 4       	#impimi string               
    	syscall
	
	li $v0, 1		#imprimi int
	move $a0, $t3		#carregar o min ser impresso
	syscall			#executar a impressao
	
	la $a0, space   	#carrega um espaco:  " "
    	li $v0, 4       	#impimi string                  
    	syscall

	syscall
    	jr $ra      		#return

	