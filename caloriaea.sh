#!/bin/bash

#=============================================================












#Versão do script
# ===============
VERSION="0.1"

#Flag de loop (s = Sim; n = Não)
# ==============================
LOOP="s"

# O programa estará em loop até o usuário clicar em sair ou cancelar
while [[ "$LOOP" == "s" ]]
do
		# Menu principal do script
		# ========================
		OPTION=$(dialog \
			--stdout \
			--title "Caloriae - v$VERSION" \
			--menu 'Escolha uma das opções abaixo:' \
			0 0 0 \
			Listar 'Lista todos os treinos salvos' \
			Adicionar 'Adiciona nova entrada' \
			Remover 'Remove um treino existente' \
			Sair 'Fechar o programa')


		# Se o usuário clicar em cancelar, encerra o loop
		# ===============================================
		if [[ -z "$OPTION" ]]; then
			dialog --title "Caloriae - v$VERSION" --msgbox 'Obrigado por usar o Caloriae!' 6 45
			LOOP="n"
		# Caso contrário, continua a execução do programa
		# ===============================================
		else
			case "$OPTION" in
			# Opção de Sair
			# Encerrando o loop e saindo do programa
			# ======================================
				"Sair")
					dialog --title "Caloriae - v$VERSION" --msgbox 'Obrigado por usar o Caloriae' 6 45
					LOOP="n"
					;;
			# Opção de Listar
			# Acusará erro caso a lista de contatos não exista
			# ================================================
				"Listar")
				if [[ -e "contatos.txt" ]]; then
					dialog --title 'Entradas' --textbox contatos.txt 0 0
				else
					dialog --title 'Erro!' --msgbox 'Lista de entradas não existe!' 6 45
				fi
				;;
			# Opção de Adicionar
			# Acusará erro quando a entrada já existir ou usuário não inserir valor
			# =====================================================================
				"Adicionar")
					NAME=$( dialog \
						--stdout \
						--title 'Qdd de calorias - Quilometragem - Duração' \
						--inputbox 'Adicione a Qdd de calorias - Quilometragem - Duração' \
						0 0)

					if [[ -z "$NAME" ]]; then
						dialog --title 'Erro!' --msgbox 'Nenhum nome inserido!' 6 45
					else
						ENTRADA=$(cat contatos.txt |
							grep "$NAME:" |
							cut -d ":" -f1)

						if [[ -z "$ENTRADA" ]]; then
							DATA=$(dialog \
							)
			esac

		fi


done
clear
