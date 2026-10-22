---
name: codigo-setup
description: Instala Git, Node.js e Remotion pro usuário, pulando o que ele já tiver. Use quando o usuário rodar /codigo-setup, pedir "instala o remotion", "configura meu ambiente" ou quiser começar a criar vídeos com código e não tiver tudo instalado.
---

# Código Setup

Objetivo: deixar a máquina pronta pra criar vídeos com Remotion. Instalar só o que falta entre: **Git**, **Node.js**, **skill do Remotion** e **projeto Remotion**.

Fale em português, simples, curto. O usuário não é programador. Antes de instalar algo, diga em uma frase o que vai instalar. Nunca use `sudo` nem Homebrew. Nunca peça senha.

## 1. Detectar o sistema

Rode `uname -s` (se falhar, é Windows/PowerShell).
- `Darwin` → **Mac**
- `MINGW*`, `MSYS*`, `CYGWIN*` ou erro → **Windows**
- `Linux` → **Linux**

## 2. Checar o que já existe

Rode tudo e anote o que existe e o que falta:

Mac/Linux/Git Bash:
```bash
git --version
node --version || { export NVM_DIR="$HOME/.nvm"; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && node --version; }
ls ~/.claude/skills/remotion-best-practices/SKILL.md ~/.codex/skills/remotion-best-practices/SKILL.md 2>/dev/null
```

PowerShell:
```powershell
git --version; node --version
Test-Path "$HOME\.claude\skills\remotion-best-practices\SKILL.md"; Test-Path "$HOME\.codex\skills\remotion-best-practices\SKILL.md"
```

Regras:
- Git respondeu versão → **pular Git**
- Node respondeu v18 ou maior → **pular Node**. Se for menor que v18, instalar.
- Skill do Remotion existe → **pular skill**

Mostre ao usuário uma lista curta: ✅ já tem / ⏳ vai instalar.

## 3. Instalar o Git (só se faltar)

**Mac:**
```bash
xcode-select --install
```
Abre uma janela do macOS. Peça ao usuário clicar em **Instalar** e avisar quando terminar. Confirme com `git --version`.

**Windows:**
```bash
winget install --id Git.Git -e --accept-source-agreements --accept-package-agreements
```
Se aparecer janela pedindo permissão, peça ao usuário clicar em **Sim**.

**Linux:** peça ao usuário rodar `sudo apt install -y git` no terminal dele.

## 4. Instalar o Node.js (só se faltar)

**Mac e Linux** — via nvm, sem senha:
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
export NVM_DIR="$HOME/.nvm" && . "$NVM_DIR/nvm.sh"
nvm install --lts
nvm alias default 'lts/*'
```
Se o Node foi instalado por nvm, em todo comando seguinte com `node`, `npm` ou `npx`, comece com:
`export NVM_DIR="$HOME/.nvm" && . "$NVM_DIR/nvm.sh" &&`

**Windows:**
```bash
winget install --id OpenJS.NodeJS.LTS -e --accept-source-agreements --accept-package-agreements
```

**Windows — reinício:** se instalou Git ou Node no Windows, o terminal atual ainda não enxerga. Peça ao usuário fechar e abrir o app (Claude Code ou Codex) e rodar a skill de novo. Ela vai pular o que já foi instalado e continuar.

## 5. Instalar a skill do Remotion (só se faltar)

Ensina o agente a criar vídeos no padrão do Remotion. Instale nas duas pastas (Claude Code e Codex).

Mac/Linux/Git Bash:
```bash
rm -rf /tmp/remotion-skills
git clone --depth 1 https://github.com/remotion-dev/skills /tmp/remotion-skills
for d in ~/.claude/skills ~/.codex/skills; do
  mkdir -p "$d"; rm -rf "$d/remotion-best-practices"
  cp -R /tmp/remotion-skills/skills/remotion-best-practices "$d/"
done
```

PowerShell:
```powershell
$tmp="$env:TEMP\remotion-skills"; Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue
git clone --depth 1 https://github.com/remotion-dev/skills $tmp
foreach ($d in "$HOME\.claude\skills","$HOME\.codex\skills") {
  New-Item -ItemType Directory -Force $d | Out-Null
  Remove-Item "$d\remotion-best-practices" -Recurse -Force -ErrorAction SilentlyContinue
  Copy-Item "$tmp\skills\remotion-best-practices" $d -Recurse
}
```

## 6. Criar o projeto Remotion (só se faltar)

Se a pasta atual já tem `package.json` com `remotion` nas dependências, **pule** — o projeto já existe.

Senão, pergunte o nome (padrão: `meu-video`, sem espaços nem acentos) e rode:
```bash
npx create-video@latest --yes --blank --no-tailwind meu-video
cd meu-video
npm i
```

## 7. Abrir o Studio
Dentro da pasta do projeto, em segundo plano:
```bash
npx remotion studio --no-open
```
Pegue a URL que aparecer (normalmente `http://localhost:3000`).

## 8. Finalizar
Responda curto:
- ✅ O que já tinha / ✅ o que foi instalado (com versões)
- Pasta do projeto
- Link do Studio
- "Pronto. Agora me pede o vídeo, ex: 'cria um vídeo de 10s com o texto X animado'."
- Se instalou a skill do Remotion agora: "Feche e abra o app uma vez pra ativar a skill do Remotion."

## Regras
- Nunca reinstale o que já existe.
- Nunca use `sudo` nem Homebrew.
- Se um passo falhar, tente uma correção óbvia uma vez. Se falhar de novo, pare e explique o erro em linguagem simples.
