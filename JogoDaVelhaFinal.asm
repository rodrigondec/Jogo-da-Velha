## Unit Width in Pixels == Unit Height in Pixels == 2
## Display Width in Pixels == Display Height in Pixels == 128


# Baseado no codigo desenvolvido por: ALINE FIGUEIREDO, CRISTIANO SANTANA, JESILENE GODOY E LUIS MIRANDA
# retirado de: https://code.google.com/p/bsimips/wiki/IdosaGame
# Este codigo foi desenvolvido por: RUBEN BARBOSA, RODRIGO CASTRO E THALES AGUIAR
.data
# Inicializacao do bitmap
bitmap_address: .space 0x8000
# Posicoes onde serao inseridos os simbolos(X e O)
posicao_1:	.word 0
posicao_2:	.word 84
posicao_3:	.word 168
posicao_4:	.word 5376
posicao_5:	.word 5460
posicao_6:	.word 5544
posicao_7:	.word 11008
posicao_8:	.word 11092
posicao_9:	.word 11176
# Posicoes do tabuleiro inicializadas em 0(Nada consta na posicao)
# Se posicao == 1, entao posicao == X
# Se posicao == 2, entao posicao == O
	li $t0, 0
	li $t1, 0
	li $t2, 0
	li $t3, 0
	li $t4, 0
	li $t5, 0
	li $t6, 0
	li $t7, 0
	li $t8, 0
# Contador de jogadas
	li $t9, 0
# Comeca a jogada com o X( X == 0 e O == 1)
	li $s7, 0
# Conjunto de mensagens do jogo
m0:	.asciiz "O X comeca jogando...\n"
m1:	.asciiz "Selecione uma posicao para jogar\n"
m2:	.asciiz "############################\n"
m3:	.asciiz "#    1   |    2    |   3   #\n"
m4:	.asciiz "#--------|---------|-------#\n"
m5:	.asciiz "#    4   |    5    |   6   #\n"
m6:	.asciiz "#--------|---------|-------#\n"
m7:	.asciiz "#    7   |    8    |   9   #\n"
m8:	.asciiz "Digite a posicao desejada:\n"
m9:	.asciiz "Posicao invalida! Tente novamente...\n"
m10: .asciiz "O X venceu!!!\n"
m11: .asciiz "O 'O' venceu!!!\n"
m12: .asciiz "Nao ha vencedores, deu velha!\n"
m13: .asciiz "Placar: \n"
m14: .asciiz "	O X esta com "
m15: .asciiz "	O 'O' esta com "
m16: .asciiz " Pontos.\n"
m17: .asciiz "Deseja jogar novamente? Escolha uma das opcoes abaixo:\n1. Sim\n2. Nao\n"
m18: .asciiz "Opcao invalida! Tente denovo...\n"



# Cores
white:   .word 0xffffff
red:     .word 0xff8888
green:   .word 0x00ff00
blue:    .word 0x8888ff
black:	 .word 0x0


	.text
	.globl main
main:
	# Inicializa o tabuleiro
	j tabuleiro
	depois_do_tabuleiro:
	
	# Inicializa o tutorial
	jal tutorial
	depois_do_tutorial:
	
	# Lendo a posicao desejada	
	li $v0, 4
	la $a0, m8
	syscall

	li $v0, 5
	syscall
	move $a0, $v0
	# Termina de ler a posicao desejada


	# Verifica se a posicao desejada eh valida e desenha a figura na posicao
	j posicao
	depois_de_posicao: 
	# Se o o jogo chegar a este estado entao deu velha!!
	li $v0, 4
	la $a0, m12
	syscall
	# Fim do jogo
	j placar

#########################################
########## INICIA O TUTORIAL ############
#########################################
tutorial:
	#Imprimir msgs
	li $v0, 4
	la $a0, m0
	syscall
	li $v0, 4
	la $a0, m1
	syscall
	li $v0, 4
	la $a0, m2
	syscall
	li $v0, 4
	la $a0, m3
	syscall
	li $v0, 4
	la $a0, m4
	syscall
	li $v0, 4
	la $a0, m5
	syscall
	li $v0, 4
	la $a0, m6
	syscall
	li $v0, 4
	la $a0, m7
	syscall
	li $v0, 4
	la $a0, m2
	syscall
	
	jr $ra
#########################################
########## TERMINA O TUTORIAL ###########
#########################################

#########################################
########### INICIA A POSICAO ############
#########################################
	
posicao:
	beq $a0, 1, um
	beq $a0, 2, dois
	beq $a0, 3, tres
	beq $a0, 4, quatro
	beq $a0, 5, cinco
	beq $a0, 6, seis
	beq $a0, 7, sete
	beq $a0, 8, oito
	beq $a0, 9, nove
	j outro
	
um:	bne $t0, $zero, outro
	addi $t9, $t9, 1
	li $t0, 2
	lw $a0, posicao_1
	bne $s7, 0, vez_da_bola1
	li $t0, 1
	jal draw_xis
	j depois_de_desenhar1
	vez_da_bola1:
	li $t0, 2
	jal draw_o
	depois_de_desenhar1:
	jal teste_vencedor
	bne $t9, 9 , depois_do_tutorial
	j end_posicao
	
dois:	bne $t1, $zero, outro
	addi $t9, $t9, 1
	lw $a0, posicao_2
	bne $s7, 0, vez_da_bola2
	li $t1, 1
	jal draw_xis
	j depois_de_desenhar2
	vez_da_bola2:
	li $t1, 2
	jal draw_o
	depois_de_desenhar2:
	jal teste_vencedor
	bne $t9, 9 , depois_do_tutorial
	j end_posicao
	
tres:	bne $t2, $zero, outro
	addi $t9, $t9, 1
	li $t2, 2
	lw $a0, posicao_3
	bne $s7, 0, vez_da_bola3
	li $t2, 1
	jal draw_xis
	j depois_de_desenhar3
	vez_da_bola3:
	li $t2, 2
	jal draw_o
	depois_de_desenhar3:
	jal teste_vencedor
	bne $t9, 9 , depois_do_tutorial
	j end_posicao
	
quatro:	bne $t3, $zero, outro
	addi $t9, $t9, 1
	li $t3, 2
	lw $a0, posicao_4
	bne $s7, 0, vez_da_bola4
	li $t3, 1
	jal draw_xis
	j depois_de_desenhar4
	vez_da_bola4:
	li $t3, 2
	jal draw_o
	depois_de_desenhar4:
	jal teste_vencedor
	bne $t9, 9 , depois_do_tutorial
	j end_posicao
	
cinco:	bne $t4, $zero, outro
	addi $t9, $t9, 1
	li $t4, 2
	lw $a0, posicao_5
	bne $s7, 0, vez_da_bola5
	li $t4, 1
	jal draw_xis
	j depois_de_desenhar5
	vez_da_bola5:
	li $t4, 2
	jal draw_o
	depois_de_desenhar5:
	jal teste_vencedor
	bne $t9, 9 , depois_do_tutorial
	j end_posicao
	
seis:	bne $t5, $zero, outro
	addi $t9, $t9, 1
	li $t5, 2
	lw $a0, posicao_6
	bne $s7, 0, vez_da_bola6
	li $t5, 1
	jal draw_xis
	j depois_de_desenhar6
	vez_da_bola6:
	li $t5, 2
	jal draw_o
	depois_de_desenhar6:
	jal teste_vencedor
	bne $t9, 9 , depois_do_tutorial
	j end_posicao
	
sete:	bne $t6, $zero, outro
	addi $t9, $t9, 1
	li $t6, 2
	lw $a0, posicao_7
	bne $s7, 0, vez_da_bola7
	li $t6, 1
	jal draw_xis
	j depois_de_desenhar7
	vez_da_bola7:
	li $t6, 2
	jal draw_o
	depois_de_desenhar7:
	jal teste_vencedor
	bne $t9, 9 , depois_do_tutorial
	j end_posicao
	
oito:	bne $t7, $zero, outro
	addi $t9, $t9, 1
	li $t7, 2
	lw $a0, posicao_8
	bne $s7, 0, vez_da_bola8
	li $t7, 1
	jal draw_xis
	j depois_de_desenhar8
	vez_da_bola8:
	li $t7, 2
	jal draw_o
	depois_de_desenhar8:
	jal teste_vencedor
	bne $t9, 9 , depois_do_tutorial
	j end_posicao
	
nove:	bne $t8, $zero, outro
	addi $t9, $t9, 1
	li $t8, 2
	lw $a0, posicao_9
	bne $s7, 0, vez_da_bola9
	li $t8, 1
	jal draw_xis
	j depois_de_desenhar9
	vez_da_bola9:
	li $t8, 2
	jal draw_o
	depois_de_desenhar9:
	jal teste_vencedor
	bne $t9, 9 , depois_do_tutorial
	j end_posicao
	
outro:	li $v0, 4
	la $a0, m9 #imprime msg de posicao invalida
	syscall
	j depois_do_tutorial
end_posicao:
	j depois_de_posicao
	
#########################################
########### TERMINA POSICAO #############
#########################################

#########################################
############# DESENHA O X ###############
#########################################
draw_xis:
	move $s2, $a0		# Endereco do inicio da primeira linha do X
	li $s3, 20		# Tamanho da linha do X
	lw $a3, green	
	j draw_x1
draw_x1:
	sw $a3, bitmap_address($s2)
	addi $s2, $s2, 4
	sw $a3, bitmap_address($s2)
	addi $s2, $s2, 256
	subi $s3, $s3, 1
	beq $s3, $zero, termina_x1
	j draw_x1
termina_x1:
	move $s2, $a0		# Endereco do inicio da segunda linha do X
	addi $s2, $s2, 84	# Leva o ponto inicial da segunda linha para o outro lado
	li $s3, 20		# Tamanho da linha do X
	lw $a3, green
	j draw_x2
draw_x2:
	sw $a3, bitmap_address($s2)
	subi $s2, $s2, 4
	sw $a3, bitmap_address($s2)
	addi $s2, $s2, 256
	subi $s3, $s3, 1
	beq $s3, $zero, termina_x2
	j draw_x2
termina_x2:
	li $s7, 1
	jr $ra

#########################################
############# TERMINA O X ###############
#########################################

#########################################
############ DESENHA O 'O' ##############
#########################################

#### Adicionar 40 ao endereco o coloca no meio da linha
#### Subtrair 80 ao endereco o coloca no inicio
draw_o:
	move $s2, $a0
	addi $s2, $s2, 44	
	li $s3, 10		
	lw $a3, blue
	j draw_o1
draw_o1:
	sw $a3, bitmap_address($s2)
	addi $s2, $s2, 4
	sw $a3, bitmap_address($s2)
	addi $s2, $s2, 256
	subi $s3, $s3, 1
	beq $s3, $zero, termina_o1
	j draw_o1
termina_o1:
	subi $s2, $s2, 84
	li $s3, 10	
	lw $a3, blue
	j draw_o2
draw_o2:
	sw $a3, bitmap_address($s2)
	addi $s2, $s2, 4
	sw $a3, bitmap_address($s2)
	addi $s2, $s2, 256
	subi $s3, $s3, 1
	beq $s3, $zero, termina_o2
	j draw_o2
termina_o2:
	move $s2, $a0
	addi $s2, $s2, 40	
	li $s3, 10		
	lw $a3, blue
	j draw_o3
draw_o3:
	sw $a3, bitmap_address($s2)
	subi $s2, $s2, 4
	sw $a3, bitmap_address($s2)
	addi $s2, $s2, 256
	subi $s3, $s3, 1
	beq $s3, $zero, termina_o3
	j draw_o3
termina_o3:
	addi $s2, $s2, 80	
	li $s3, 10		
	lw $a3, blue
	j draw_o4
draw_o4:
	sw $a3, bitmap_address($s2)
	subi $s2, $s2, 4
	sw $a3, bitmap_address($s2)
	addi $s2, $s2, 256
	subi $s3, $s3, 1
	beq $s3, $zero, termina_o4
	j draw_o4
termina_o4:
	li $s7, 0
	jr $ra

#########################################
############ TERMINA O 'O' ##############
#########################################

#########################################
######### DESENHA O TABULEIRO ###########
#########################################
tabuleiro:	
	#### DESENHA AS LINHAS #####
	li $s2, 5372	# Posicao inicial da linha horizontal mais acima
	li $s3, 64	# Tamanho da linha horizontal
	lw $a3, white	# Cor da linha horizontal mais acima
	jal draw_line
	li $s2, 11004	# Posicao inicial da linha horizontal mais abaixo
	li $s3, 64
	lw $a3, white
	jal draw_line
	j end_linha
draw_line:
	sw $a3, bitmap_address($s2)	# Adiciona a cor a posicao inicial da linha no bitmap
	subi $s2, $s2, 4		# Avanca para o proximo bit no bitmap
	subi $s3, $s3, 1		# Decrementa o tamanho da linha
	beq $s3, $zero, termina_linha	# Verifica se a linha foi totalmente desenhada
	j draw_line
termina_linha:
	jr $ra
end_linha:
	#### DESENHA AS COLUNAS #####
	li $s2, 84	# Posicao inicial da coluna mais a esquerda
	li $s3, 64	# Tamanho da coluna
	lw $a3, white	# Cor da coluna
	jal draw_colum
	li $s2, 168	# Posicao inicial da coluna mais a direita
	li $s3, 64
	lw $a3, white
	jal draw_colum
	j end_coluna
draw_colum:
	sw $a3, bitmap_address($s2)	# Adiciona a cor a posicao inicial da coluna no bitmap
	addi $s2, $s2, 256		# Avanca para o proximo bit, abaixo do bit anterior, no bitmap
	subi $s3, $s3, 1		# Decrementa o tamanho da coluna
	beq $s3, $zero, termina_coluna	# Verifica se a coluna foi totalmente desenhada
	j draw_colum
termina_coluna:
	jr $ra
end_coluna:
	j depois_do_tabuleiro
#########################################
######### TERMINA O TABULEIRO ###########
#########################################

#########################################
########## INICIA O VENCEDOR ############
#########################################
teste_vencedor:
	## Teste das linhas
	beq $t0, $zero, linha2
	bne $t0, $t1, linha2
	bne $t1, $t2, linha2
	li $s2, 2556	# Posicao inicial da linha horizontal mais abaixo
	li $s3, 64
	lw $a3, red
	draw_line1:
		sw $a3, bitmap_address($s2)	# Adiciona a cor a posicao inicial da linha no bitmap
		subi $s2, $s2, 4		# Avanca para o proximo bit no bitmap
		subi $s3, $s3, 1		# Decrementa o tamanho da linha
		beq $s3, $zero, vencedor	# Verifica se a linha foi totalmente desenhada
		j draw_line1
	linha2:
	beq $t3, $zero, linha3
	bne $t3, $t4, linha3
	bne $t4, $t5, linha3
	li $s2, 7932	# Posicao inicial da linha horizontal mais abaixo
	li $s3, 64
	lw $a3, red
	draw_line2:
		sw $a3, bitmap_address($s2)	# Adiciona a cor a posicao inicial da linha no bitmap
		subi $s2, $s2, 4		# Avanca para o proximo bit no bitmap
		subi $s3, $s3, 1		# Decrementa o tamanho da linha
		beq $s3, $zero, vencedor	# Verifica se a linha foi totalmente desenhada
		j draw_line2
	linha3:
	beq $t6, $zero, coluna1
	bne $t6, $t7, coluna1
	bne $t7, $t8, coluna1
	li $s2, 13308	# Posicao inicial da linha horizontal mais abaixo
	li $s3, 64
	lw $a3, red
	draw_line3:
		sw $a3, bitmap_address($s2)	# Adiciona a cor a posicao inicial da linha no bitmap
		subi $s2, $s2, 4		# Avanca para o proximo bit no bitmap
		subi $s3, $s3, 1		# Decrementa o tamanho da linha
		beq $s3, $zero, vencedor	# Verifica se a linha foi totalmente desenhada
		j draw_line3
	## Teste das colunas
	coluna1:
	beq $t0, $zero, coluna2
	bne $t0, $t3, coluna2
	bne $t3, $t6, coluna2
	li $s2, 40	# Posicao inicial da coluna mais a direita
	li $s3, 64
	lw $a3, red
	draw_colum1:
		sw $a3, bitmap_address($s2)	# Adiciona a cor a posicao inicial da coluna no bitmap
		addi $s2, $s2, 256		# Avanca para o proximo bit, abaixo do bit anterior, no bitmap
		subi $s3, $s3, 1		# Decrementa o tamanho da coluna
		beq $s3, $zero, vencedor	# Verifica se a coluna foi totalmente desenhada
		j draw_colum1
	coluna2:
	beq $t1, $zero, coluna3
	bne $t1, $t4, coluna3
	bne $t4, $t7, coluna3
	li $s2, 124	# Posicao inicial da coluna mais a direita
	li $s3, 64
	lw $a3, red
	draw_colum2:
		sw $a3, bitmap_address($s2)	# Adiciona a cor a posicao inicial da coluna no bitmap
		addi $s2, $s2, 256		# Avanca para o proximo bit, abaixo do bit anterior, no bitmap
		subi $s3, $s3, 1		# Decrementa o tamanho da coluna
		beq $s3, $zero, vencedor	# Verifica se a coluna foi totalmente desenhada
		j draw_colum2
	coluna3:
	beq $t2, $zero, diagonal1
	bne $t2, $t5,  diagonal1
	bne $t5, $t8,  diagonal1
	li $s2, 208				# Posicao inicial da coluna mais a direita
	li $s3, 64
	lw $a3, red
	draw_colum3:
		sw $a3, bitmap_address($s2)	# Adiciona a cor a posicao inicial da coluna no bitmap
		addi $s2, $s2, 256		# Avanca para o proximo bit, abaixo do bit anterior, no bitmap
		subi $s3, $s3, 1		# Decrementa o tamanho da coluna
		beq $s3, $zero, vencedor	# Verifica se a coluna foi totalmente desenhada
		j draw_colum3
	## Teste das diagonais
	diagonal1:
	beq $t0, $zero, diagonal2
	bne $t0, $t4,  diagonal2
	bne $t4, $t8,  diagonal2
	li $s2, 0
	li $s3, 64				# Tamanho da linha do X
	lw $a3, red
	diag1:
		sw $a3, bitmap_address($s2)
		addi $s2, $s2, 4
		sw $a3, bitmap_address($s2)
		addi $s2, $s2, 256
		subi $s3, $s3, 1
		beq $s3, $zero, vencedor
		j diag1
	diagonal2:
	beq $t2, $zero, nao_cheio
	bne $t2, $t4,  nao_cheio
	bne $t4, $t6,  nao_cheio
	li $s2, 252
	li $s3, 64				# Tamanho da linha do X
	lw $a3, red
	diag2:
		sw $a3, bitmap_address($s2)
		subi $s2, $s2, 4
		sw $a3, bitmap_address($s2)
		addi $s2, $s2, 256
		subi $s3, $s3, 1
		beq $s3, $zero, vencedor
		j diag2
vencedor:
	bne $s7, 1, bola_ganhou
	j xis_ganhou
xis_ganhou:
	addi $a1, $a1, 1
	li $v0, 4
	la $a0, m10
	syscall
#	li $v0, 4
#	la $a0, m13 ##### precisa mesmo imprimir "FIM DE JOGO" ?
#	syscall
	j placar
bola_ganhou:
	addi $a2, $a2, 1
	li $v0, 4
	la $a0, m11
	syscall
#	li $v0, 4
#	la $a0, m13 ##### precisa mesmo imprimir "FIM DE JOGO" ?
#	syscall
	j placar
nao_cheio:
	jr $ra
	
#########################################
########## TERMINA O VENCEDOR ###########
#########################################
placar:
	li $v0, 4
	la $a0, m13 #placar:
	syscall
	li $v0, 4
	la $a0, m14 #X esta com
	syscall
	li $v0, 1
	la $a0, ($a1) #quantidade pontos || SUBSTITUIR POR UM REGISTRADOR
	syscall
	li $v0, 4
	la $a0, m16 #pontos
	syscall
	li $v0, 4
	la $a0, m15 #O esta com
	syscall
	li $v0, 1
	la $a0, ($a2) #quantidade pontos || SUBSTITUIR POR UM REGISTRADOR
	syscall
	li $v0, 4
	la $a0, m16 #pontos
	syscall

end_game:
	#Jogar novamente?
	li $v0, 4
	la $a0, m17
	syscall
	
	li $v0, 5
	syscall
	move $a0, $v0
	# Termina de ler a opcao inserida
	
	##### RESETANDO VARI�VEIS DE JOGO ####
	# Posicoes
	li $t0, 0
	li $t1, 0
	li $t2, 0
	li $t3, 0
	li $t4, 0
	li $t5, 0
	li $t6, 0
	li $t7, 0
	li $t8, 0
	# Contador de jogadas
	li $t9, 0
	# Vez
	li $s7, 0
	
	#Precisa resetar o bitmap display antes

	
	beq $a0, 1, limpa_tabuleiro	#  branch to target if  $t0 = $t1
	
	beq $a0, 2, fim
	
	#opcao invalida
	li $v0, 4
	la $a0, m18
	syscall
	
	j end_game

limpa_tabuleiro:
	#### LIMPEZA DO TABULEIRO ####
	li $s2, 0	# Posicao inicial primeira linha
	li $s3, 4095	# Tamanho da linha horizontal
	li $a3, 0	# Cor preta
apaga:
	sw $a3, bitmap_address($s2)	# Adiciona a cor a posicao inicial da coluna no bitmap
	addi $s2, $s2, 4		# Avanca para o proximo bit, abaixo do bit anterior, no bitmap
	subi $s3, $s3, 1		# Decrementa o tamanho da coluna
	beq $s3, $zero, tabuleiro
	j apaga
fim:
