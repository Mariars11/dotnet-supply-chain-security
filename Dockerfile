
# ==========================================
# ETAPA 1 - Compilação da aplicação
# ==========================================
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

# Copia o projeto e restaura as dependências
COPY src/ProdutosApi/ProdutosApi.csproj ./ProdutosApi/
RUN dotnet restore ./ProdutosApi/ProdutosApi.csproj

# Copia o código e publica a aplicação
COPY src/ProdutosApi/ ./ProdutosApi/
RUN dotnet publish ./ProdutosApi/ProdutosApi.csproj \
    -c Release \
    -o /app/publish \
    --no-restore

# ==========================================
# ETAPA 2 - Execução da aplicação
# ==========================================
FROM mcr.microsoft.com/dotnet/aspnet:8.0

WORKDIR /app

COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:8080

EXPOSE 8080

# CORREÇÃO DE SEGURANÇA:
# Executa a aplicação sem privilégios de root
USER app

ENTRYPOINT ["dotnet", "ProdutosApi.dll"]