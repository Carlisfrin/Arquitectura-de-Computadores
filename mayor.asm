        .data
inicio: .asciiz "Introduce los numeros a comparar\n"
fin:    .asciiz "El mayor es: "

        .text
main:   la $a0, inicio
        li $v0, 4
        syscall
        
	li $v0, 5
        syscall
        add $t0, $v0, $zero
        
        li $v0, 5
        syscall
        add $t1, $v0, $zero
        
        la $a0, fin
        li $v0, 4     
        syscall
        
        bgt $t0, $t1, salto
       
        add $a0, $t1, $zero
        li $v0, 1
        syscall
        
        li $v0, 10
        syscall
        
salto:  add $a0, $t0, $zero
        li $v0, 1
        syscall
        
        li $v0, 10
        syscall