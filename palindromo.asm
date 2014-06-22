        .data
inicio: .asciiz "Introduce la palabra a analizar\n"
si:     .asciiz "Es palindromo\n"
no:     .asciiz "No es palindromo\n"
cadena: .space 1024

        .text
main:   la $a0, inicio
        li $v0, 4
        syscall #imprime el mensaje inicio
        
        la $a0, cadena
        li $a1, 1024
	li $v0, 8
        syscall
        
        add $t0, $zero, $a0 #guarda el string en $t0
        
        add $t4, $zero, $t0
        
        addi $t3, $t0, 1024
        addi $t0, $zero, '\n'
        
busca: 	lb $t2, 0($t3) #el puntero $t2 apunta al final del string       
        subi $t3, $t3, 1
	beq $t2, $t0, found	# llegamos al \0?
	j busca
	
found:	lb $t2, 0($t3)
	lb $t1, 0($t4)
	
	bne $t2, $t1, fail
	bgt $t4, $t3, win
	
	subi $t3, $t3, 1
	addi $t4, $t4, 1
	j found
	
win:    la $a0, si
        li $v0, 4
        syscall #imprime el mensaje inicio
        j exit
	
fail:   la $a0, no
        li $v0, 4
        syscall 
        
exit:	li $v0, 10
        syscall #el programa acaba
