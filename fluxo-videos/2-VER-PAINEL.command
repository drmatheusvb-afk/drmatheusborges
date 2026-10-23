#!/bin/bash
# Gera PAINEL.html com tudo o que esta em cada etapa e abre no navegador.
# Uso: dois cliques em VER-PAINEL.command (dentro da pasta VIDEOS)

RAIZ="${VIDEOS_RAIZ:-$HOME/VIDEOS}"
SAIDA="$RAIZ/PAINEL.html"

if [ ! -d "$RAIZ" ]; then
  echo "Pasta $RAIZ nao existe. Rode primeiro o 1-INSTALAR.command."
  exit 1
fi

# pasta | titulo | quem age | o que fazer
ETAPAS=(
  "1_MANDAR_CRU|Video cru recebido|Editor|Pegar o video, mover para 2_EDITANDO e comecar a edicao"
  "2_EDITANDO|Em edicao|Editor|Quando a previa estiver pronta, colocar em 3_PARA_APROVAR"
  "3_PARA_APROVAR|Esperando aprovacao|Camila / Matheus|Assistir. Aprovou: mover para 4_APROVADO_RENDERIZAR. Ajustes: escrever no arquivo de mesmo nome .txt"
  "4_APROVADO_RENDERIZAR|Aprovado, falta renderizar|Editor|Renderizar a versao final e salvar em 5_PRONTOS_PARA_POSTAR"
  "5_PRONTOS_PARA_POSTAR|Pronto para postar|Quem posta|Postar e mover para 6_POSTADOS"
  "6_POSTADOS|Postados|Ninguem|Arquivo. Nada a fazer"
)

esc() { sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g'; }

{
cat <<'HTML'
<!doctype html><html lang="pt-br"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Painel de Videos</title>
<style>
:root{--bg:#faf8f3;--card:#fff;--txt:#222;--sub:#666;--line:#e6e0d2;--gold:#b8932a;--alert:#a3242f}
@media (prefers-color-scheme:dark){:root{--bg:#16181d;--card:#1f2229;--txt:#eee;--sub:#9aa;--line:#2e323b;--gold:#d4af37;--alert:#e06470}}
body{margin:0;background:var(--bg);color:var(--txt);font:15px/1.45 -apple-system,system-ui,sans-serif;padding:24px 16px}
h1{font-weight:600;margin:0 0 4px}.sub{color:var(--sub);margin:0 0 24px}
.etapa{background:var(--card);border:1px solid var(--line);border-radius:10px;padding:16px;margin:0 0 14px;max-width:900px}
.etapa.tem{border-left:4px solid var(--gold)}.etapa.urgente{border-left:4px solid var(--alert)}
.top{display:flex;justify-content:space-between;gap:12px;flex-wrap:wrap;align-items:baseline}
h2{font-size:17px;margin:0}.n{font-weight:700;color:var(--gold)}.urgente .n{color:var(--alert)}
.quem{color:var(--sub);font-size:13px}.fazer{margin:6px 0 10px;color:var(--sub)}
ul{margin:0;padding-left:18px}li{margin:3px 0}a{color:inherit}.data{color:var(--sub);font-size:12px;margin-left:6px}
.nota{background:var(--bg);border-radius:6px;padding:6px 8px;margin:4px 0 6px;font-size:13px;white-space:pre-wrap}
.vazio{color:var(--sub);font-style:italic}
</style></head><body>
<h1>Painel de Videos</h1>
HTML
echo "<p class=\"sub\">Atualizado em $(date '+%d/%m/%Y as %H:%M'). Para atualizar, rode VER-PAINEL.command de novo.</p>"

for linha in "${ETAPAS[@]}"; do
  IFS='|' read -r pasta titulo quem fazer <<< "$linha"
  dir="$RAIZ/$pasta"
  arquivos=()
  while IFS= read -r f; do arquivos+=("$f"); done < <(
    find "$dir" -maxdepth 1 -type f ! -name '.*' ! -name '*.txt' 2>/dev/null | sort
  )
  n=${#arquivos[@]}
  classe="etapa"
  if [ "$n" -gt 0 ]; then
    classe="etapa tem"
    [ "$pasta" = "3_PARA_APROVAR" ] && classe="etapa urgente"
  fi
  echo "<section class=\"$classe\"><div class=\"top\"><h2>$(echo "$titulo" | esc) <span class=\"n\">($n)</span></h2>"
  echo "<span class=\"quem\">Pasta $pasta &middot; vez de: $(echo "$quem" | esc)</span></div>"
  echo "<p class=\"fazer\">$(echo "$fazer" | esc)</p>"
  if [ "$n" -eq 0 ]; then
    echo "<p class=\"vazio\">Nada aqui.</p>"
  else
    echo "<ul>"
    # Postados: mostra so os 15 mais recentes
    [ "$pasta" = "6_POSTADOS" ] && arquivos=("${arquivos[@]: -15}")
    for f in "${arquivos[@]}"; do
      nome="$(basename "$f")"
      data="$(date -r "$f" '+%d/%m %H:%M' 2>/dev/null)"
      url="file://$(echo "$f" | sed 's/ /%20/g')"
      echo "<li><a href=\"$url\">$(echo "$nome" | esc)</a><span class=\"data\">$data</span>"
      nota="${f%.*}.txt"
      [ -f "$nota" ] && echo "<div class=\"nota\">Ajustes: $(esc < "$nota")</div>"
      echo "</li>"
    done
    echo "</ul>"
  fi
  echo "</section>"
done
echo "</body></html>"
} > "$SAIDA"

echo "Painel gerado: $SAIDA"
open "$SAIDA" 2>/dev/null || true
