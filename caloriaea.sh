#!/bin/bash

#=============================================================












#Versão do script
# ===============
VERSION="0.2"

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
				if [[ -e "cofredecalorias.txt" ]]; then
					dialog --title 'Cofre' --textbox cofredecalorias.txt 0 0
				else
					dialog --title 'Erro!' --msgbox 'Lista de entradas não existe!' 6 45
				fi
				;;
			# Opção de Adicionar
			# Acusará erro quando a entrada já existir ou usuário não inserir valor
			# =====================================================================
				"Adicionar")
					IDENTIFICACAO=$( dialog \
						--stdout \
						--title 'Identificação' \
						--inputbox 'Digite a sua Identificação!' \
						0 0)

					if [[ -z "$IDENTIFICACAO" ]]; then
						dialog --title 'Erro!' --msgbox 'Nenhum identificação inserida!' 6 45
					else
						ENTRADA=$(cat cofredecalorias.txt |
							grep "$IDENTIFICACAO:" |
							cut -d ":" -f1)

						if [[ -z "$CALORIAS" ]]; then
							CALORIAS=$(dialog \
								--stdout \
								--title 'Calorias' \
								--inputbox 'Adicione o número de calorias perdidas em seu treino!' \
							0 0)

							if [[ -z "$CALORIAS" ]]; then
								dialog --title 'Erro!' --msgbox 'Nenhuma contagem de calorias feita!' 6 45
							else
								echo "$IDENTIFICACAO: $CALORIAS" >> cofredecalorias.txt
								dialog --title 'Adicionado!' --msgbox 'Contagem feita com sucesso!' 6 45
							fi
						else
							dialog --title 'Erro!' --msgbox 'Contato já existe!' 6 45
						fi
					fi
					;;

				# Opção de Remover 
				# Acusará erro caso contato não exista ou usuário não inserir valor
				# =================================================================
					"Remover")
						IDENTIFICACAO=$( dialog \
							--stdout \
							--title 'Remover contagem da data' \
							--inputbox 'Insira a identificação da data a ser removida
										Formato(DDMMMAAAA) Ex: 22set2020' \
							0 0)

						if [[ -z "$IDENTIFICACAO" ]]; then
							dialog --title 'Erro!' --msgbox 'Nenhuma identificação inserida!' 6 45
						else
							ENTRADA=$(cat cofredecalorias.txt |
								grep "$IDENTIFICACAO:" |
								cut -d ":" -f1)

							if [[ -z "$ENTRADA" ]]; then
								dialog --title 'Erro!' --msgbox 'Identificação não existe!' 6 45
							else
								sed -i /"$ENTRADA:"/d cofredecalorias.txt
								dialog --title 'Removido!' --msgbox 'Contagem removida com sucesso!' 6 45
							fi
						fi
						;;
			esac
		fi
done
clear
