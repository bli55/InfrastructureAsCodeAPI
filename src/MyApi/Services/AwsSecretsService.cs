using Amazon.SecretsManager;
using Amazon.SecretsManager.Model;
using System.Text.Json;

public class AwsSecretsService : ISecretsService
{
    private readonly IAmazonSecretsManager _sm;

    public AwsSecretsService(IAmazonSecretsManager sm) => _sm = sm;

    public async Task<Dictionary<string, string>> GetSecretsAsync()
    {
        var secretName = Environment.GetEnvironmentVariable("SECRET_NAME")
            ?? throw new InvalidOperationException("SECRET_NAME environment variable not set");

        var response = await _sm.GetSecretValueAsync(new GetSecretValueRequest
        {
            SecretId = secretName
        });

        return JsonSerializer.Deserialize<Dictionary<string, string>>(response.SecretString)!;
    }
}
