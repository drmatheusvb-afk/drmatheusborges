# Pasta VIDEOS — instruções para o Claude

Esta pasta é o fluxo de produção de vídeos do Dr. Matheus Borges e da Dra. Camila Vilela.
Quem fala com você aqui normalmente **não é técnico** (muitas vezes é a Camila).
Responda em português, curto, sem jargão, dizendo sempre **em que pasta** está cada coisa.

## Etapas (a pasta onde o arquivo está É o status)

1. `1_MANDAR_CRU` — vídeo cru recebido, ninguém começou
2. `2_EDITANDO` — editor trabalhando
3. `3_PARA_APROVAR` — prévia esperando aprovação da Camila ou do Matheus
4. `4_APROVADO_RENDERIZAR` — aprovado, falta exportar a versão final
5. `5_PRONTOS_PARA_POSTAR` — render final, pronto para postar
6. `6_POSTADOS` — arquivo
- `_projetos` — arquivos do editor; não mexa sem pedido explícito.

Ajustes pedidos ficam num `.txt` com o mesmo nome-base do vídeo, na mesma pasta.

## Pedidos comuns e o que fazer

- **"O que está pendente?" / "como estão os vídeos?"**
  Liste cada etapa com quantidade e nomes, destacando primeiro o que está em
  `3_PARA_APROVAR` (é a vez dela) e quantos ajustes `.txt` existem. Ofereça rodar `./VER-PAINEL.command`.
- **"Mandei um vídeo" / "coloca esse vídeo pra editar"**
  Se ela indicar um arquivo fora da pasta, copie (não mova) para `1_MANDAR_CRU`,
  renomeando para `AAAA-MM-DD_tema.ext` com a data de hoje e um tema curto em minúsculas com hífens.
- **"Aprovo o vídeo X" / "pode renderizar"**
  Mova o vídeo de `3_PARA_APROVAR` para `4_APROVADO_RENDERIZAR`. Se existir `.txt` de ajuste dele,
  mova junto e renomeie para `...APROVADO.txt` para manter o histórico.
- **"Pede ajuste no vídeo X: ..."**
  Crie/acrescente no `.txt` de mesmo nome-base em `3_PARA_APROVAR`, com data e o texto dela. Não mova o vídeo.
- **"Cadê o vídeo pronto de X?" / "onde está o render?"**
  Procure em `5_PRONTOS_PARA_POSTAR` (e depois em `6_POSTADOS`). Responda com o caminho completo e
  ofereça abrir no Finder (`open -R "<caminho>"`).
- **"Já postei o X"** → mova de `5_PRONTOS_PARA_POSTAR` para `6_POSTADOS`.

## Regras

- Nunca apague vídeos. Nunca sobrescreva: se o nome já existir no destino, acrescente `_v2`, `_v3`...
- Ao identificar um vídeo pelo nome que a pessoa falou, se houver mais de um parecido, pergunte qual.
- Depois de mover qualquer coisa, diga em uma linha: *"<vídeo> agora está em <pasta>."*
- Se encontrar arquivo solto na raiz da pasta VIDEOS, pergunte em qual etapa ele deve ir.
