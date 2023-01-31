#########################################################
# Script para criar solução completa em camadas em .NET #
# Licença : MIT                                         #
# Autor: Sidnei Brianti - scbrianti2022@gmail.com       #
#########################################################


# Solicita o nome da solução ao usuário
$solutionName = Read-Host "Digite o nome da solução"

# Array tipo e projeto
$a =@(("classlib","classlib","mstest","classlib","webapi"),
    ("$solutionName.Domain","$solutionName.Shared","$solutionName.Test","$solutionName.Infra","$solutionName.Api"))

# Criar Diretório
mkdir $solutionName

# Entra no diretório da solução
cd $solutionName

# Cria a solução
dotnet new sln

# Cria a gitignore
dotnet new gitignore

# Loop de criação dos projetos
for($i=0; $i -le 4; $i++)
{
    $tipoProjeto =$a[0][$i] 
    $nomeProjeto = $a[1][$i]
    # Cria o projeto 
    dotnet new $tipoProjeto -n $nomeProjeto
    
    # Remove arquivo Class1
    if(Test-Path $nomeProjeto\Class1.cs){
        rm $nomeProjeto\Class1.cs
    }
    # Adiciona o projeto Domain à solução
    dotnet sln add $nomeProjeto/$nomeProjeto.csproj
}
# Limpa o terminal
clear

# Build soluçao
dotnet build

# Sai do diretório da solução
cd ..    


# Exibe uma mensagem de sucesso
Write-Host "Solução " -NoNewline
Write-Host $solutionName -ForegroundColor green -NoNewline
Write-Host " criada com sucesso com projetos:\n\n" 
Write-Host ""

for($i=0; $i -le 4; $i++)
{
    $nomeProjeto = $a[1][$i]
    Write-Host " - $nomeProjeto"
}

