public interface ISecretsService
{
    Task<Dictionary<string, string>> GetSecretsAsync();
}
