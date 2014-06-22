        .data
inicio: .asciiz "Introduce el numero y su mayor multiplo\n"
fin:    .asciiz "Los multiplos son:\n"
eol:    .asciiz "\n"

        .text
main:   la $a0, inicio
        li $v0, 4
        syscall #imprime el mensaje inicial
        
	li $v0, 5
        syscall
        add $t0, $v0, $zero #coje el primer multiplo y lo guarda en $t0
        
        li $v0, 5
        syscall
        add $t1, $v0, $zero #coje el segundo multiplo y lo guarda en $t1
        
        blez $t1, exit #si el segundo es menor o igual a 0, el programa termina
        
        la $a0, fin
        li $v0, 4     
        syscall #imprime el mensaje fin
        
        
        add $t2, $zero, 2 #guarda un 1 en $t2

	add $a0, $t0, $zero
        li $v0, 1
        syscall #imprime el primer multiplo
        
        add $t3, $t0, $zero #guarda el primer multiplo en $t3
        
bucle:  ble $t2,$t1, multi #salta a multi si el contador $t2 es menor o igual que $t1

exit:   li $v0, 10
        syscall #el programa acaba
        
multi:  la $a0, eol
        li $v0, 4     
        syscall #imprime un salto de linea

        add $t3, $t3, $t0 #calcula el numero a imprimir
        addi $t2, $t2, 1 #aumenta el contador en 1
        
        add $a0, $t3, $zero
        li $v0, 1
        syscall #imprime el numero actual
        
        j bucle #vuelve a bucle         
        

