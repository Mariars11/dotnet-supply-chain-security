
var builder = WebApplication.CreateBuilder(args);

// Configuração do Swagger
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();


// Swagger disponível apenas em desenvolvimento
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

var produtos = new List<Produto>
{
    new(1, "Notebook", 3500.00m, 10),
    new(2, "Mouse", 89.90m, 50),
    new(3, "Teclado", 159.90m, 25)
};

// Verifica se a API está funcionando
app.MapGet("/health", () =>
    Results.Ok(new
    {
        status = "Healthy",
        timestamp = DateTimeOffset.UtcNow
    }));

// Lista todos os produtos
app.MapGet("/produtos", () =>
    Results.Ok(produtos));

// Consulta um produto pelo ID
app.MapGet("/produtos/{id:int}", (int id) =>
{
    var produto = produtos.FirstOrDefault(p => p.Id == id);

    return produto is not null
        ? Results.Ok(produto)
        : Results.NotFound(new { mensagem = "Produto não encontrado" });
});

app.Run();

record Produto(int Id, string Nome, decimal Preco, int Estoque);
