using Amazon.SecretsManager;

var builder = WebApplication.CreateBuilder(args);

if (builder.Environment.IsDevelopment())
{
    builder.Services.AddSingleton<ISecretsService, DevSecretsService>();
}
else
{
    // On ECS the task role provides credentials automatically.
    // Region is set via AWS_DEFAULT_REGION in the task definition.
    var region = Amazon.RegionEndpoint.GetBySystemName(
        Environment.GetEnvironmentVariable("AWS_DEFAULT_REGION") ?? "us-east-1");
    builder.Services.AddSingleton<IAmazonSecretsManager>(new AmazonSecretsManagerClient(region));
    builder.Services.AddSingleton<ISecretsService, AwsSecretsService>();
}

var app = builder.Build();

app.MapGet("/health", () => Results.Ok(new { status = "healthy", timestamp = DateTime.UtcNow }));

app.MapGet("/secret-demo", async (ISecretsService secrets) =>
{
    var values = await secrets.GetSecretsAsync();

    // Never return secret values — only show that retrieval worked and which keys exist
    return Results.Ok(new
    {
        message = app.Environment.IsDevelopment()
            ? "Secrets loaded from local appsettings (Development)"
            : "Secrets retrieved from AWS Secrets Manager (Production)",
        environment = app.Environment.EnvironmentName,
        availableKeys = values.Keys
    });
});

app.Run();
