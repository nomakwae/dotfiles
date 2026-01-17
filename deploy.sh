#!/usr/bin/bash

DEPLOY="\e[01;31m[DEPLOY]:\e[00m"

alias cp="cp --preserve=all"

if command -v sudo &>/dev/null; then
	DOAS="sudo"
elif command -v doas &>/dev/null; then
	DOAS="doas"
fi

# checking for lsp support
if ! command -v typescript-language-server &>/dev/null; then
	echo -e "${DEPLOY} installing typescript-language-server"
	"$DOAS" npm install -g typescript typescript-language-server
fi

if ! command -v gopls &>/dev/null; then
	echo -e "${DEPLOY} installing gopls"
	go install golang.org/x/tools/gopls@latest
fi

if ! command -v emmet-language-server &>/dev/null; then
	echo -e "${DEPLOY} installing emmet-language-server"
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
				echo -e "${DEPLOY} overwrote $1"
				return 0 ;;
			[Nn]* )
				echo -e "${DEPLOY} skipping..."
				return 1 ;;
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
	echo -e "${DEPLOY} ${NVIM_DIR} already exists."
	if ! diff -r "${NVIM_DIR}" nvim/ &>/dev/null; then
		prompt "${NVIM_DIR}" "nvim/" "${CONFIG_HOME}"
	else
		echo -e "${DEPLOY} files are the same, skipping."
		:
	fi
else
	cp -r nvim/ "${CONFIG_HOME}"
fi

ST_DIR="${CONFIG_HOME}/st"
if command -v st &>/dev/null && [[ -d "${ST_DIR}" ]]; then
	echo -e "${DEPLOY} ${ST_DIR} already exists."
	if ! diff -r "${ST_DIR}" st &>/dev/null; then
		if prompt "${ST_DIR}" "st/" "${CONFIG_HOME}"; then
			cd "${ST_DIR}"
			echo -e "${DEPLOY} compiling st"
			"${DOAS}" make clean install
			cd -
		fi
	else
		echo -e "${DEPLOY} files are the same, skipping."
		:
	fi
else
	cp -r st/ "${CONFIG_HOME}"
	cd "${ST_DIR}"
	echo -e "${DEPLOY} compiling st"
	"${DOAS}" make install
	cd -
fi

BASHRC="${HOME}/.bashrc"
if [ -e "${BASHRC}" ]; then
	echo -e "${DEPLOY} ${BASHRC} already exists."
	if ! diff "${BASHRC}" ".bashrc" &>/dev/null; then
		prompt "${BASHRC}" ".bashrc" "${HOME}"
	else
		echo -e "${DEPLOY} files are the same, skipping."
	fi
else
	cp .bashrc "${HOME}"
fi
