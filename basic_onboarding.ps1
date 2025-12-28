# Força o console a mostrar acentos corretamente
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Limpa a tela para o usuário
Clear-Host

Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host "       CONFIGURAÇÃO INICIAL DE IDIOMA - SETUP        " -ForegroundColor Cyan
Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Escolha o idioma desejado para este computador:"
Write-Host "1 - Manter em Português (Brasil)"
Write-Host "2 - Instalar e mudar para Inglês (Estados Unidos)"
Write-Host ""

$escolha = Read-Host "Digite o número da sua opção"

switch ($escolha) {
    "1" {
        Write-Host "Iniciando a instalação do pacote de idioma Português (BR)..." -ForegroundColor Yellow
        Write-Host "Isso pode levar alguns minutos dependendo da conexão..." -ForegroundColor Gray
        
        # Instala o pacote de idioma
        try {
            Install-Language pt-BR -ErrorAction Stop
            
            # Define como idioma da interface (UI)
            Set-WinUILanguageOverride -Language pt-BR
            
            # Define formatos regionais (Data, Moeda)
            Set-Culture pt-BR
            
            # Define localidade do sistema (Administrative)
            Set-WinSystemLocale pt-BR
            
            Write-Host "Português BR instalado e configurado com sucesso!" -ForegroundColor Green
            Write-Host "AVISO: As mudanças terão efeito total após reiniciar." -ForegroundColor Magenta
        }
        catch {
            Write-Host "Erro ao instalar o idioma. Verifique a conexão com a internet." -ForegroundColor Red
        }
    }
    
    "2" {
        Write-Host "Iniciando a instalação do pacote de idioma Inglês (US)..." -ForegroundColor Yellow
        Write-Host "Isso pode levar alguns minutos dependendo da conexão..." -ForegroundColor Gray
        
        # Instala o pacote de idioma
        try {
            Install-Language en-US -ErrorAction Stop
            
            # Define como idioma da interface (UI)
            Set-WinUILanguageOverride -Language en-US
            
            # Define formatos regionais (Data, Moeda)
            Set-Culture en-US
            
            # Define localidade do sistema (Administrative)
            Set-WinSystemLocale en-US
            
            Write-Host "Inglês instalado e configurado com sucesso!" -ForegroundColor Green
            Write-Host "AVISO: As mudanças terão efeito total após reiniciar." -ForegroundColor Magenta
        }
        catch {
            Write-Host "Erro ao instalar o idioma. Verifique a conexão com a internet." -ForegroundColor Red
        }
    }
    
    Default {
        Write-Host "Opção inválida. Nenhuma alteração de idioma foi feita." -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Pressione qualquer tecla para continuar com a instalação das ferramentas de OnBoarding..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# 2. Instalação de Softwares via Winget (Exemplos comuns)
Write-Host ""
Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host "       FERRAMENTAS BÁSICAS DO ONBOARDING GGBR        " -ForegroundColor Cyan
Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Instalando softwares básicos..." -ForegroundColor Cyan
Write-Host ""

$apps = @(
	"AnyDesk.AnyDesk",
    "Google.Chrome",
	"Google.GoogleDrive",
	"Adobe.Acrobat.Reader.64-bit",
	"Learnpulse.Screenpresso",
    "SlackTechnologies.Slack",
	"Microsoft.Teams",
    "Zoom.Zoom",
	"Microsoft.Office"
)

foreach ($app in $apps) {
    Write-Host ""
    Write-Host "Instalando: $app" -ForegroundColor Yellow
    Write-Host ""
    winget install --id $app --silent --source winget
    Write-Host ""
}

# 3. Limpeza de Bloatware (Opcional - Ex: Remover TikTok, Disney+ que vêm no Windows)
Write-Host ""
Write-Host "Removendo itens desnecessários..." -ForegroundColor Cyan
Write-Host ""
Get-AppxPackage *TikTok* | Remove-AppxPackage
Get-AppxPackage *DisneyPlus* | Remove-AppxPackage
Get-AppxPackage *OneDrive* | Remove-AppxPackage
Get-AppxPackage *9NRX63209R7B* | Remove-AppxPackage     #Outlook For Windows
Get-AppxPackage *9MZ95KL8MR0L* | Remove-AppxPackage     #Snipping Tool   
Write-Host ""
Write-Host "Setup concluído! O sistema precisa ser reiniciado." -ForegroundColor Green