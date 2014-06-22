	.data
stro:	.space 1024
strd:	.space 1024
orig:	.asciiz "Cadena origen: "
dest:	.asciiz "Cadena destino: "

	.text
main:	
	subu $sp, $sp, 32	#
	sw $ra, 20($sp)		# Creo el marco de pila para el main.
	sw $fp, 16($sp)		#
	addi $fp, $sp, 28	#
	
	li $v0,4		#
	la $a0,dest		# Imprimo "Cadena destino: ".
	syscall			#
	
	la $a0, strd		#
	li $a1, 1024		# Salto a la subrutina que lee el string.
	jal read_string		#
	
	li $v0,4		#
	la $a0,orig		# Imprimo "Cadena origen: ".
	syscall			#
	
	la $a0, stro		#
	li $a1, 1024		# Salto a la subrutina que lee el string.
	jal read_string		#
	
	la $a0, strd		# Paso como primer argumento el string de destino
	la $a1, stro		# y como segundo el string de origen.
	
	sw $a0, 4($sp)		# Salvo los valores de $a0 y $a1 para recuperarlos después
	sw $a1, 8($sp)		# de la llamada a la subrutina.
	
	jal strcpy		# Invoco a la subrutina.
	
	lw $a0, 4($sp)		# Recupero los valores de las direcciones de cada string.
	lw $a1, 8($sp)		#
	
	li $v0, 4		# Imprimo el string que hay en $a0, es decir, la cadena destino.
	syscall
	
	li $v0, 10		# Exit.
	syscall

read_string:	
	li $v0, 8		# Llamada al sistema para leer de la consola.
	syscall
	jr $ra			# Retorno.
	
strlen:	
	move $v0, $zero		# Inicializo $v0 a 0.
loop_strlen:
	lb $v1, 0($a0)		# Cargo el primer byte de la cadena.
	beq $v1, '\0', ret_strlen # Comparo si es el final de cadena para retornar.
	addi $v0, $v0, 1	#
	addi $a0, $a0, 1	# Incremento contador ($v0) y posición en la cadena ($a0).
	j loop_strlen		
ret_strlen:
	subu $a0, $a0, $v0	# Recupero la posición inicial de la cadena.
	jr $ra			# Retorno.
	
strcpy:
	subu $sp, $sp, 32	#
	sw $ra, 20($sp)		# Creo un nuevo marco de pila y salvo los valores
	sw $fp, 16($sp)		# de $s0 y $s1 ya que los voy a modificar a lo largo
	sw $s0, 4($sp)		# de la subrutina.
	sw $s1, 8($sp)		#
	addi $fp, $sp, 28	#
	
	move $s0, $a0		# Copio los valores de las cadenas en registros temporales.
	move $s1, $a1		#
	move $a0, $a1		# Paso como primer y único argumento a la subrutina strlen lo que tenía
	jal strlen		# almacenado en $a1, que sería la cadena origen.
loop_strcpy:
	beqz $v0, ret_strcpy	# Si el strlen vale 0, retorno.
	lb $v1, 0($s1)		# Cargo el valor del byte de la cadena origen
	sb $v1, 0($s0)		# y lo almaceno en la misma posición de la cadena destino.
	addi $s0, $s0, 1	#
	addi $s1, $s1, 1	# Incremento contadores, y disminuyo el valor de $v0 ya que hemos copiado 1 byte más.
	subu $v0, $v0, 1	#
	j loop_strcpy
ret_strcpy:
	sb $zero, 0($s0)	# Copio el caracter '\0' al final de lo ya copiado
	lw $s0, 4($sp)		#
	lw $s1, 8($sp)		# Desapilo el valor de retorno y recupero los valores
	lw $ra, 20($sp)		# de $s0 y $s1 antes de ser modificados.
	lw $fp, 16($sp)		#
	addi $sp, $sp, 32	#
	jr $ra			# Retorno.
