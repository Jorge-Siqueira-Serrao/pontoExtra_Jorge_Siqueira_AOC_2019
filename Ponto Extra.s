# fonte Bárbara
.data
	array .WORD 3,2,5,1
.text
	.global inicio
	
	inicio:
		li $s1,4 		#n=4
		la $s2,array
		li $s3,0 		#c=0
		slt $s4,$s3,$s1		#se c<4 $s4=1
		beq $s4,1,LB1		#se $s4=1 go to LB1
		sub $t1,$s1,1		#$t1=4-1
		slt $s4,$s3,$t1		#se c<n-1 $s4=1
		beq $s4,1,LB2		#se $s4=1 go to LB2
		j Fim			
	LB1:
		li $v0,5		#recebe inteiro
		syscall
		move $t1,$v0		#$t1 recebe o inteiro
		add $t2,$s3,$s3		#c*4=$t2
		add $t2,$t2,$t2
		sw $t1,$t2($s2)		#array[$t2]=$t1
		addi $s3,$s3,1		#c++
		jr $ra
	LB2:
		li $s5,0		#d=0
		sub $t2,$s1,$s3		#$t2=n-c
		sub $t2,$t2,1		#$t2=n-c-1
		slt $s6,$s5,$t2		#se d<$t2 $s6=1
		beq $s6,1,LB3		#se $s6=1 go to LB3
		addi $s3,$s3,1		#d++
		jr $ra
	LB3:
		add $t4,$s5,$s5		#d*4
		add $t4,$t4,$t4
		la $t3,$t4($s2)		#$t3 = array[$t4]
		addi $t4,$t4,4		#$t4++
		la $t5,$t4($s2)		$t5 = array[$t4]
		slt $s7,$t5,$t3		#se array[d-1]<array[d] $s7=1
		beq $s7,1,LB4		#se $s7=1 go to LB4
		addi $s5,$s5,1
		jr $ra
	LB4:
		move $t6,$t3		#swap = array[d]
		move $t3,$t5		#array[d] = array[d+1]
		move $t5,$t6		#array[d+1] = swap
		jr ra
	Fim:
		li $v0,10
		syscall