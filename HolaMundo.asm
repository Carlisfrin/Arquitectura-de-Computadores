      .data
str:  .asciiz "Hola mundo en MIPS32\n"

      .text
main: la $a0, str
      li $v0, 4
      
      syscall
      
      li $v0, 10
      syscall           