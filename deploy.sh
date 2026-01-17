#!/usr/bin/bash

if command -v sudo &>/dev/null; then
	DOAS="sudo"
elif command -v doas &>/dev/null; then
	DOAS="doas"
fi

# checking for lsp support
if ! command -v typescript-language-server &>/dev/null; then
	echo "installing typescript-language-server"
	"$DOAS" npm install -g typescript typescript-language-server
fi

if ! command -v gopls &>/dev/null; then
	echo "installing gopls"
	go install golang.org/x/tools/gopls@latest
fi

if ! command -v emmet-language-server &>/dev/null; then
	echo "installing emmet-language-server"
	"$DOAS" npm i -g @olrtg/emmet-language-server
fi
prompt() {
	while true; do
		echo "Overwrite?"
		echo ""
		echo "[y]es, [n]o, view [d]iffs"

		read -r choice

		case $choice in
			[Yy]* )
				rm -r $1
				cp -r $2 $3
				echo "overwrote $1"
				break ;;
			[Nn]* )
				echo "skipping..."
				break ;;
			[Dd]* )
				diff --color=auto -r $1 $2
				;;
			* )
				;;
		esac
	done
}

CONFIG_HOME="${HOME}/.config"

NVIM_DIR="${CONFIG_HOME}/nvim"
if [[ -d "${NVIM_DIR}" ]]; then
	echo "${NVIM_DIR} already exists."
	if ! diff -r "${NVIM_DIR}" nvim/ &>/dev/null; then
		prompt "${NVIM_DIR}" "nvim/" "${CONFIG_HOME}"
	else
		echo "files are the same, skipping."
		:
	fi
else
	cp -r nvim/ "${CONFIG_HOME}"
fi

ST_DIR = "${CONFIG_HOME}/st"
if command -v st &>/dev/null && [[ -d "${ST_DIR}" ]]; then
	if ! diff st/x.c "${ST_DIR}/x.c" &>/dev/null; then
		prompt "${ST_DIR}" "st/" "${CONFIG_HOME}"
		cd "${ST_DIR}"
		"${DOAS}" make clean install
	else
		echo "files are the same, skipping."
		:
	fi
else
	cp -r st/ "${CONFIG_HOME}"
	cd "${ST_DIR}"
	"${DOAS}" make install
fi
