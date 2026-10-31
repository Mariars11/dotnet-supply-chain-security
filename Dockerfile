
# Etapa de compilação
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

COPY src/ProdutosApi/ProdutosApi.csproj ./ProdutosApi/
RUN dotnet restore ./ProdutosApi/ProdutosApi.csproj

COPY src/ProdutosApi/ ./ProdutosApi/
RUN dotnet publish ./ProdutosApi/ProdutosApi.csproj \
    -c Release \
    -o /app/publish \
    --no-restore

# Etapa de execução
FROM mcr.microsoft.com/dotnet/aspnet:8.0

WORKDIR /app

COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:8080

EXPOSE 8080

# VULNERABILIDADE INTENCIONAL:
# Não definimos um usuário não privilegiado.
# A imagem executará como root por padrão.

ENTRYPOINT ["dotnet", "ProdutosApi.dll"]