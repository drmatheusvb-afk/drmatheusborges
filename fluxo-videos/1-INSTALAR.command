#!/bin/bash
# Cria a pasta VIDEOS no Mac com o fluxo de producao padrao.
# Uso: dois cliques neste arquivo (ou: bash 1-INSTALAR.command)
# Pode rodar quantas vezes quiser: nunca apaga nem move nada que ja existe.

ORIGEM="$(cd "$(dirname "$0")" && pwd)"
RAIZ="${VIDEOS_RAIZ:-$HOME/VIDEOS}"

ETAPAS=(
  "1_MANDAR_CRU"
  "2_EDITANDO"
  "3_PARA_APROVAR"
  "4_APROVADO_RENDERIZAR"
  "5_PRONTOS_PARA_POSTAR"
  "6_POSTADOS"
  "_projetos"
)

echo "Criando estrutura em: $RAIZ"
mkdir -p "$RAIZ"
for etapa in "${ETAPAS[@]}"; do
  mkdir -p "$RAIZ/$etapa"
done

# Instrucoes para o Claude local (Claude Code / Cowork) que abrir esta pasta
cp "$ORIGEM/CLAUDE.md" "$RAIZ/CLAUDE.md"
cp "$ORIGEM/COMO-USAR.md" "$RAIZ/COMO-USAR.md"
cp "$ORIGEM/2-VER-PAINEL.command" "$RAIZ/VER-PAINEL.command"
chmod +x "$RAIZ/VER-PAINEL.command"

# Atalho na Mesa
if [ ! -e "$HOME/Desktop/VIDEOS" ]; then
  ln -s "$RAIZ" "$HOME/Desktop/VIDEOS"
fi

echo ""
echo "Pronto. A pasta VIDEOS esta na Mesa."
echo "Para ver o que esta pendente: dois cliques em VER-PAINEL.command"
open "$RAIZ" 2>/dev/null || true
