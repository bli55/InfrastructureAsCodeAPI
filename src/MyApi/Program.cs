using Amazon.SecretsManager;
using Amazon.SecretsManager.Model;
using System.Text.Json;

var builder = WebApplication.CreateBuilder(args);

// AWS SDK automatically uses the ECS task IAM role credentials at runtime,
// and local ~/.aws credentials in development
builder.Services.AddSingleton<IAmazonSecretsManager>(new AmazonSecretsManagerClient());

var app = builder.Build();

app.MapGet("/health", () => Results.Ok(new { status = "healthy", timestamp = DateTime.UtcNow }));

app.MapGet("/secret-demo", async (IAmazonSecretsManager sm) =>
{
    var secretName = Environment.GetEnvironmentVariable("SECRET_NAME")
        ?? throw new InvalidOperationException("SECRET_NAME environment variable not set");

    var response = await sm.GetSecretValueAsync(new GetSecretValueRequest
    {
        SecretId = secretName
    });

    var secrets = JsonSerializer.Deserialize<Dictionary<string, string>>(response.SecretString)!;

    // Never return secret values — only demonstrate that retrieval worked
    return Results.Ok(new
    {
        message = "Secrets retrieved successfully via IAM task role",
        secretName,
        availableKeys = secrets.Keys
    });
});

app.Run();
