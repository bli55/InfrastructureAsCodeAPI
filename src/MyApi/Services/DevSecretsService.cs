public class DevSecretsService : ISecretsService
{
    private readonly IConfiguration _config;

    public DevSecretsService(IConfiguration config) => _config = config;

    public Task<Dictionary<string, string>> GetSecretsAsync()
    {
        var secrets = _config.GetSection("DevSecrets").Get<Dictionary<string, string>>()
            ?? new Dictionary<string, string>();
        return Task.FromResult(secrets);
    }
}
